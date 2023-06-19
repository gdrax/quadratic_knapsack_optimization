% Backward substitution to find the solution of a upper triangular linear
% system
%
% @param U: [n x n] upper trinagular matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solutiom of Ux=b

function x = backward_sub(U, b)
    n = size(U, 1);
    x = zeros(n, 1);
    for i = n:-1:1
        tmp = b(i);
        for j = i+1:n
            tmp = tmp - U(i, j) * x(j);
        end
        x(i) = tmp / U(i, i);
    end
end