% Active-set algorithm for quadratic non separable % knapsack problems of
% the form:
%           min xQx + qx 
%      s.t. a_i * x_i <= b forall i
%           0 <= x <= u
% with Q posiive semidefinite.
%
% -@param KP: A quadratic non-separable knapsack problem structure with the
%             following fields
% --KP.Q: [n x n] real symmetric semidefinite matrix
% --KP.q: [n x 1] real vector
% --KP.u: [n x 1] real positive vector
% --KP.l: [n x 1] zeros vector
% --KP.a: [n x 1] real positive vector
% --KP.b: real positive scalar
% 
% @param max_iter: positive int maximum mumber of iteration
% @param verbose
% @param matlab: boolean whether to use matlab functions (A \ b, ldl, null)
% @param toll: positive real, tollerance for the equalities with 0
% @param ret_info: boolean, to return info on the computation
% @param start P: char, starting strategy:
%                 'l' - starting x = [0, ..., 0]
%                 'f' - starting x = u / 2 ^ i

% @return x: optimal solution of the problem, or the last one before stop
% @return info: structure of info on the computation
%               info.it: vector of iterations i
%               info.gap: vector of || x_i - xs_i ||
%               info.vgap: vector of || f(x_i) - f(xs_i) ||

function [x, info] = ASKP(KP, max_iter, toll, start_P, varargin)
    matlab = false;
    verbose = false;
    ret_info = false;
    if ~isempty(varargin)
        matlab = varargin{1};
        if length(varargin) > 1
            verbose = varargin{2};
            if length(varargin) > 2
                ret_info = varargin{3};
            end
        end
    end
    tic;
    g = 0;
%     toll = 1e-10;
    x = KP.u / 2;
    i = 2;
    info.it = zeros(1, 1);
    info.gap = zeros(1, 1);
    info.vgap = zeros(1, 1);
    % find a initial feasible solution
    if start_P == 'f'
        while(KP.a' * x >= KP.b)
            x = KP.u / (2^i);
            i = i + 1;
        end
    else
        if start_P == 'l'
            x = KP.l;
        end
    end
    AS = active_set(x, KP, toll);
    i = 0;
    while (true)
        i = i + 1;
        if i == max_iter
            status = 'Max iter';
            info = log(KP, x, i, '/', info, ret_info);
            break
        end
        [K, qb] = reduced_KKT_system(KP, AS);
        if ~matlab
            [L, D, P, s] = BP_fact_stop(K);
        else
            [L, D, P] = ldl(K);
            s = false;
        end
        if s
            if verbose
                disp("singular")
            end
            if matlab
                N = null(K);
            else
                N = BP_kernel_first(L, D, P);
            end
            [v, g] = quad_func_value(KP.Q, KP.q, x);
            d = descent_direction(N, AS, toll, g, KP.q);
        else
            if verbose
                disp("non-singular")
            end
            if matlab
                [xf, mu_K] = solve_KKT_matlab(K, qb, AS.k);
            else
                [xf, mu_K] = solve_KKT(L, D, P, qb, AS.k);
            end
            xs = x;
            xs(AS.F) = xf;
            if primal_feasible(xs, KP, toll)
                if verbose
                    disp("solution is feasible")
                end
                [v, g] = quad_func_value(KP.Q, KP.q, xs);
                [AS, df] = remove_dual_unfeasible(g, KP.a, mu_K, AS, toll, verbose);
                if df
                    x = xs;
                    info = log(KP, x, i, '*', info, ret_info);
                    status = 'Optimal';
                    break
                else
                    %a constraint has been removed from the active set
                    x = xs;
                    info = log(KP, x, i, '-', info, ret_info);
                    continue
                end
            end
            d = xs - x;
        end

        info = log(KP, x, i, '+', info, ret_info);
        
        % find the maximum feasible step alpha-bar
        Gu = AS.F & d > toll;
        alpha_bar = min((KP.u(Gu) - x(Gu)) ./ d(Gu));
        Gl = AS.F & d < -toll;
        alpha_bar = min([alpha_bar min(-x(Gl) ./ d(Gl))]);
        if KP.a' * d > toll && ~AS.k
            alpha_bar = min([alpha_bar (KP.b - KP.a' * x) / (KP.a' * d)]);
        end

        x = x + alpha_bar * d;

        if ~primal_feasible(x, KP, toll)
            status = "Unfeasible iteration";
            info = log(KP, x, i, '/', info, ret_info);
            break
        end
        % recompute active set
%         old_AS = AS;
        AS = active_set(x, KP, toll);
%         disp(sum(AS.U)-sum(old_AS.U))
    end
    fprintf("Status: %s\n", status)
    toc;
end


% -------------------------------------------------------------------------
% computes the active set partitioning resulting form the box constraints
% returns a structure with
% AS.L - mask for the variables sticked to the lower bound
% AS.U - mask for the variables sticked to the upper bound
% AS.F - mask for the free variables
% AS.k - whether the knapsack constraint is active or not
function AS = active_set(x, KP, toll)
    AS.U = abs(KP.u - x) < toll;
    AS.L = abs(x - KP.l) < toll;
    AS.F = ~AS.U & ~AS.L;
    AS.k = abs(KP.a' * x - KP.b) < toll;
end


% -------------------------------------------------------------------------
% constructs the KKT system reduced to the free variables, of the form:
%     Q_FF |  a_F      x_F        q_F + u_U * Q_UF
%   -------------  *  -----  =  ------------------
%      a_F |  0       mu_K        b - a_U * u_U   
function [K, qb] = reduced_KKT_system(KP, AS)
    Qff = KP.Q(AS.F, AS.F);
    if any(AS.U)
        qb = -KP.q(AS.F) - (KP.u(AS.U)' * KP.Q(AS.U, AS.F))';
    else
        qb = -KP.q(AS.F);
    end
    len = size(Qff, 1);
    if AS.k
        K = zeros(len+1, len+1);
        K(1:len, 1:len) = Qff;
        K(1:len, end) = KP.a(AS.F);
        K(end, 1:len) = KP.a(AS.F)';
        qb(end+1, 1) = KP.b - KP.a(AS.U)' * KP.u(AS.U);
    else
        K = Qff;
    end
end


% -------------------------------------------------------------------------
% constructs and solve the KKT system sing the Bunch-Parlett decomposition
% of K, which is assumed to be invertible
function [xf, mu_K] = solve_KKT(L, D, P, qb, knap)
    if knap
        xf_mu = solve_BPfact(L, D, P, qb);
        xf = xf_mu(1:end-1);
        mu_K = xf_mu(end);
    else
        xf = solve_BPfact(L, D, P, qb);
        mu_K = NaN;
    end
end


function [xf, mu_K] = solve_KKT_matlab(K, qb, knap)
    if knap
        xf_mu = K \ qb;
        xf = xf_mu(1:end-1);
        mu_K = xf_mu(end);
    else
        xf = K \ qb;
        mu_K = NaN;
    end
end


% -------------------------------------------------------------------------
% check primal feasibility
function pf = primal_feasible(x, KP, toll)
    pf = all(x <= KP.u + toll & x >= -toll) && KP.a' * x <= KP.b + toll;
end

% -------------------------------------------------------------------------
% find the first constraint that is dual infeasible, and removes it from
% the active set, if none is found the solution is dual feasible
function [AS, df] = remove_dual_unfeasible(g, a, mu_K, AS, toll, verbose)
    df = false;
    if mu_K < toll
        if verbose
            disp('removing kapsack')
        end
        AS.k = false;
    else
        if AS.k
            h = find(AS.L & (g + mu_K * a) < toll, 1, 'first');
        else
            h = find(AS.L & g < toll, 1, 'first');
        end
        if ~isempty(h)
            if verbose
                fprintf('Removing from lower bound: %d\n', h)
            end
            AS.L(h) = false;
            AS.F(h) = true;
        else
            if AS.k
                h = find(AS.U & (g + mu_K * a) > -toll, 1, 'first');
            else
                h = find(AS.U & g > -toll, 1, 'first');
            end
            if ~isempty(h)
                if verbose
                    fprintf('Removing from upper bound: %d\n', h)
                end
                AS.U(h) = false;
                AS.F(h) = true;
            else
                df = true;
            end
        end
    end
end

% -------------------------------------------------------------------------
% solve a non-singular linear system using the Bunch-Parlett factorization
function x = solve_BPfact(Lt, D, P, b)
    y = forward_sub(Lt, P*b);
    z = solve_block_diag(D, y);
    x = backward_sub(Lt', z);
    x = (x'*P)';
end

% -------------------------------------------------------------------------
% log function
function info = log(KP, x, i, c, info, ret_info)
    v = quad_func_value(KP.Q, KP.q, x);
    acc = norm(KP.xs - x);
    if ret_info
        info.it(end+1) = i;
        info.gap(end+1) = norm(KP.xs-x);
        info.vgap(end+1) = norm(quad_func_value(KP.Q, KP.q, KP.xs)-v);
    end
    fprintf("%d\t-\t Error: %e\tValue: %f %s \n", i, acc, v, c)
end

% -------------------------------------------------------------------------
% find an infinite descent direction using a vector n from the kernel of
% the matrix K, if n*g < 0 then n is chosen, otherwise -n is chosen.
function d = descent_direction(N, AS, toll, g, q)
    d = zeros(size(g));
    if AS.k
        N = N(1:end-1, :);
    end
    for i=1:size(N, 2)
        if abs(N(:, i)'*g(AS.F)) > toll
            if N(:, i)'*g(AS.F) < 0
                d(AS.F) = N(:, i);
            else
                d(AS.F) = -N(:, i);
            end
            break
        end
    end
end