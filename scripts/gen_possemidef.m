% Generate a positive semidefinite matrix of size n
%
% @param n: positive int, the size of the matrix
% @param z: positive int < n, the number of zero eigenvalues
%
% @return A: [n x n] positive semidefinite symmetric matrix
% @return b: [n x 1] real random vector

function [A, b] = gen_possemidef(n, z)
    if z >= n
        error('z must be < n')
    end
    m = n-z;
    A = randn(n, m);
    A = A*A';
    b = randn(n, 1);
end