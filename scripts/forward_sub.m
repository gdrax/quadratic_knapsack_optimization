% Forward substitution to find the solution of a lower triangular linear
% system
%
% @param L: [n x n] lower trinagular matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solutiom of Lx=b

function x = forward_sub(L, b)
    n = size(L, 1);
    x = zeros(n, 1);
    for i = 1:n
        tmp = b(i);
        for j = 1:i-1
            tmp = tmp - L(i, j) * x(j);
        end
        if L(i, i) < 10e-12
            error("The system has no solution")
        end
        x(i) = tmp / L(i, i);
    end
end