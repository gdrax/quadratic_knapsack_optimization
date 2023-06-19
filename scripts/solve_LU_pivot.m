% Solve a non singular linear system with LU decomposition and
% backward and forward substitution
%
% @param A: [n x n] real non singular symmetric matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solution of Ax=b

function x = solve_LU_pivot(A, b)
    [L, U, P] = LU_pivot(A);
    y = forward_sub(L, P*b);
    x = backward_sub(U, y);
end