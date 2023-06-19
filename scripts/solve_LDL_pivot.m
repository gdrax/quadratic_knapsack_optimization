% Solve a non singular symmetric linear system with LDL decomposition and
% backward and forward substitution
%
% @param A: [n x n] real non singular symmetric matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solution of Ax=b

function x = solve_LDL_pivot(A, b)
    [L, D, P] = LDL_pivot(A);
    y = forward_sub(L, P*b);
    z = solve_block_diag(D, y);
    x = backward_sub(L', z);
    x = (x'*P)';
end