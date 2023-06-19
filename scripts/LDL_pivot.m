% LDL factorization for symmetric matrices with pivoting
%
% @param A: [n x n] real symmetric matrix
%
% @return L: [n x n] real lower triangular matrix with ones on the main
% diagonal
% @return D: [n x n] real diagonal matrix
% @return P: [n x n] permutation matrix

function [L, D, P] = LDL_pivot(A)
n = size(A);
if isequal(n(1), n(2))
    n = size(A, 1);
    L = eye(n);
    D = A;
    P = eye(n);
    for i = 1:n-1
        if any(any(D(i:end, i:end) > 1e-12))
            [val, p] = max(abs(D(i:end, i)));
            pos = p + i - 1;
            D([pos, i], i:end) = D([i, pos], i:end);
            D(i:end, [i, pos]) = D(i:end, [pos, i]);
            L([pos, i], 1:i-1) = L([i, pos], 1:i-1);
            P([pos, i], 1:end) = P([i, pos],1:end);
    
            L(i+1:end, i) = D(i+1:end, i) / D(i,i);
            D(i+1:end, i) = 0;
            D(i+1:end, i+1:end) = D(i+1:end, i+1:end) - L(i+1:end, i) * D(i, i+1:end);
% %             D(i+1, i+1) = A(i+1, i+1);
            D(i, i+1:end) = 0;
        else
            break;
        end
    end
else
    error('Matrix is not square');
end