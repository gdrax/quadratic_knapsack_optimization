% Generates an instance of a box constrained quadratic problem with a
% knapsack constraint of the form:
% (KP) = {1/2 x^T  * Q * x + q * x: 0 <= x <= u, a * x <= b}

% @param n: positive integer scalar, the number of variables of the problem
% @param z: positive integer scalar, the number of zero eigenvalues of Q if
% it's singular
% @param b: positive real scalar, value b of the knapsack constraint
% @param actv: the percentage of active box constraints at the optimum
% @param ecc: the eccentrcity of the matrix Q

% @return KP: a struct containing an instance of the problem
%             KP.Q: [n x n] real symmetric semidefinite matrix
%             KP.q: [n x 1] real vector
%             KP.u: [n x 1] real positive vector, the upper bound
%             KP.l: [n x 1] zeros vector, the lower bound
%             KP.a: [n x 1] real positive vector, coefficients of the
%                   knapsack constraint
%             KP.b: real positive scalar
%             KP.xs: [n x 1] real vector, the optimal solution of the
%                   problem
function KP = gen_knapsack(n, z, b, varargin)
    if isempty( varargin )
        actv = 0.6;
        ecc = 0.6;
    else
        actv = varargin{1};
        ecc = 0.6;
        if length(varargin) > 1
            ecc = varargin{2};
        end
    end
%     umin = 0.032;
%     umax = 1.23;
    amin = 1;
    amax = 1;
    KP.l = zeros(n, 1);
%     KP.u = umin * ones( n , 1 ) + ( umax - umin ) * rand( n , 1 );
    BC = genBCQP(n, actv, 1.7, ecc, 43);
    if z > 0
        KP.Q = gen_possemidef(n, z);
    else
        KP.Q = BC.Q;
    end
    KP.q = BC.q;
    KP.u = BC.u;
    KP.b = b;
    KP.a = amin * ones( n , 1 ) + ( amax - amin ) * rand( n , 1 );
    tic;
    KP.xs = quadprog(KP.Q, KP.q, KP.a', KP.b, [], [], KP.l, KP.u);
    toc;