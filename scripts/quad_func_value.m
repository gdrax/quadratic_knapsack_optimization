% Value of a quadratic function f = 1/2*xQx + qx
%
% @param Q: [n x n] real symmetric matrix
% @param q: [n x 1] real vector
% @param x: [n x 1] real vector

% @return v: [n x 1] real vector, the value of f in x
% @return g: [n x 1] real vector, the gradient of f in x
function [v, g] = quad_func_value(Q, q, x)
    v = (1/2) * x' * Q * x + q' * x;
    g = Q * x + q;
end