% Solve a block diagonal system with substitution and 2x2 inverses
%
% @param D: [n x n] block diagonal real non-singular matrix with 2x2 and
% 1x1 blocks
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solution of Dx=b

function x = solve_block_diag(D, b)
    n = size(D, 1);
    x = zeros(n, 1);
    i = 1;
    while i<=n
        if i ~= n && D(i+1, i) ~= 0
            x(i:i+1) = mini_inv(D(i:i+1, i:i+1))*b(i:i+1);
            i = i +2;
        else
            x(i) = b(i)/D(i,i);
            i = i + 1;
        end
    end
end