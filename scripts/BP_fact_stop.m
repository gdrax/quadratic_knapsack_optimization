% Bunch-Parlett algorithm for symmetric matrices factorization, using 1x1
% and 2x2 pivots.
% If a zero element on the diagonal matrix D is found, the factorization is
% stopped and sub matrices L_r and D_r of size [n-z+1 x n-z+1] where z is
% the number of 0 eigeinvalues of A, are returned.
%
% @param A: [n x n] real symmetric matrix

% @return L: [n x n] (or [n-z+1 x n-z+1] if A singular) lower triangular
% real matrix with ones on the main diagonal.

% @return D: [n x x] (or [n-z+1 x n-z+1] with last diagonal element = 0 if
% singular) block diagonal real matrix, with 1x1 and 2x2 blocks

% @return P: [n x n] permutation matrix

% @return singular: boolean, whether or not the matrix A is singular.

function [L, D, P, singular] = BP_fact_stop(A)
    if isequal(size(A, 1), size(A, 2))
        n = size(A, 1);
        L = eye(n);
        D = zeros(n, n);
        P = eye(n);
        alpha = (1+sqrt(17))/8;
        i = 1;
        singular = false;
        while i <= n
            if any(any(abs(A(i:end, i:end)) > 1e-12))
                % z are the max values of each column and r are the respetive
                % row number
                [z, r] = max(abs(A(i:end, i:end)));
                % mu0 is the max off-diagonal element and c it's relative
                % position (column)
                [mu0, c] = max(z);
                % mui is the max diagolnal element and d it's relative position
                [mui, d] = max(abs(diag(A(i:end, i:end))));
                if mui >= alpha*mu0 || i==n
                    % 1x1 pivoting
                    % absolute diag position of pivot
                    dp = i + d -1;
                    % bring diag pivot to A(i,i)
                    A = sym_swap(A, i, dp, i);
                    % update other matrices
                    L([i, dp], 1:i-1) = L([dp, i], 1:i-1);
                    P([i, dp], :) = P([dp, i], :);
    
                    % update factorization
                    D(i, i) = A(i, i);
                    if abs(D(i, i)) <= 1e-12
                        singular = true;
                        D = D(1:i, 1:i);
                        L = L(1:i, 1:i);
                        break
                    end
                    L(i+1:end, i) = A(i+1:end, i) / D(i,i);
                    A(i+1:end, i+1:end) = A(i+1:end, i+1:end) - L(i+1:end, i) * A(i, i+1:end);
                    i = i + 1;
                else
                    % 2x2 block pivoting
                    % absolute off diag col position of pivot
                    cp = i + c - 1;
                    % absolute off diag row position of pivot
                    rp = i + r(c) -1;
                    % bring max off diag element to A(i+1,i)
                    A = sym_swap(A, i, cp, i);
                    A = sym_swap(A, i+1, rp, i);
                    % update other matrices
                    L([i, cp], 1:i-1) = L([cp, i], 1:i-1);
                    P([i, cp], :) = P([cp, i], :);
                    L([i+1, rp], 1:i-1) = L([rp, i+1], 1:i-1);
                    P([i+1, rp], :) = P([rp, i+1], :);
    
                    % update factorization
                    D(i:i+1, i:i+1) = A(i:i+1, i:i+1);
                    L(i+2:end, i:i+1) = A(i+2:end, i:i+1) * mini_inv(D(i:i+1,i:i+1));
                    A(i+2:n, i+2:n) = A(i+2:n, i+2:n) - L(i+2:end, i:i+1) * A(i:i+1, i+2:end);
                    i = i + 2;
                end
            else
                singular = true;
                L = L(1:i, 1:i);
                D = D(1:i, 1:i);
                break
            end
        end
    else
        error('Matrix is not square');
    end
end