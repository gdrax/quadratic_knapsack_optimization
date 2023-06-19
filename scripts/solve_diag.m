% Solve a diagonal system with substitution
%
% @param D: [n x n] diagonal real non-singular matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solution of Dx=b

function x = solve_diag(D, b)
    n = size(D, 1);
    x = zeros(n, 1);
    for i=1:n
        [v, p] = max(abs(D(i, :)));
        x(p) = b(i) / D(i, p);
    end
end