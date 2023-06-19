% LDL factorization for symmetric matrices
%
% @param A: [n x n] real symmetric matrix
%
% @return L: [n x n] real lower triangular matrix with ones on the main
% diagonal
% @return D: [n x n] real diagonal matrix

function [L, D] = LDL_fact(A)
n = size(A);
if isequal(n(1), n(2))
    n = size(A, 1);
    L = eye(n);
    D = A;
    for i = 1:n-1
        if any(any(abs(D(i:end, i:end)) > 1e-12))
            L(i+1:end, i) = D(i+1:end, i) / D(i,i);
            D(i+1:end, i) = 0;
            D(i+1:end, i+1:end) = D(i+1:end, i+1:end) - L(i+1:end, i) * D(i, i+1:end);
            D(i, i+1:end) = 0;
        else
            disp(i)
            break
        end
    end
else
    error('Matrix is not square');
end