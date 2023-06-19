% LU factorization with pivoting
% @param A: [n x n] real matrix
%
% @return L: [n x n] real lower triangular matrix with ones on the main
% diagonal
% @return U: [n x n] real upper trinagular matrix
% @return P: [n x n] permutation matrix

function [L, U, P] = LU_pivot(A)
n = size(A);
if isequal(n(1), n(2))
    n = size(A, 1);
    L = eye(n);
    U = A;
    P = eye(n);
    for i = 1:n-1
        if any(any(U(i:end, i:end)))
            [val, p] = max(abs(U(i:end, i)));
            pos = p + i - 1;
            U([pos, i], i:end) = U([i, pos], i:end);
            L([pos, i], 1:i-1) = L([i, pos], 1:i-1);
            P([pos, i], 1:end) = P([i, pos],1:end);
    
            L(i+1:end, i) = U(i+1:end, i) / U(i,i);
            U(i+1:end, i) = 0;
            U(i+1:end, i+1:end) = U(i+1:end, i+1:end) - L(i+1:end, i) * U(i, i+1:end);
        else
            break;
        end
    end

else
    error('Matrix is not square');
end