% Generate a positive definite matrix of size n
%
% @param n: positive int
%
% @return A: [n x n] positive definite symmetric matrix
% @return b: [n x 1] real random vector

function [A, b] = gen_posdef(n)
    A = randn(n, n);
    A = A*A';
    b = randn(n, 1);
end