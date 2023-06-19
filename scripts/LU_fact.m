% LU factorization
% @param A: [n x n] real matrix
%
% @return L: [n x n] real lower triangular matrix with ones on the main
% diagonal
% @return U: [n x n] real upper trinagular matrix

function [L, U] = LU_fact(A)
n = size(A);
if isequal(n(1), n(2))
    n = size(A, 1);
    L = eye(n);
    U = A;
    for i = 1:n-1
        if any(any(U(i:end, i:end)))
            L(i+1:end, i) = U(i+1:end, i) / U(i,i);
            U(i+1:end, i) = 0;
            U(i+1:end, i+1:end) = U(i+1:end, i+1:end) - L(i+1:end, i) * U(i, i+1:end);
        else
            break
        end
    end

else
    error('Matrix is not square');
end