% Generates a possibly indefinite linear system K * x = b with
%       Q  | a^T
% K =  ---------
%       a  |  0
% with Q positive semidefinite

% @param n: positive int, the number of variables

% @return K: [n x n] real symmetric matrix
% @return b: [n x 1] real vector

function [K, b] = gen_K(n)
    K = zeros(n, n);
    Q = gen_possemidef(n-1, 1);
    a = randn(1, n-1);
    K(1:n-1, 1:n-1) = Q;
    K(n, 1:n-1) = a;
    K(1:n-1, n) = a';
    b = randn(n, 1);
end