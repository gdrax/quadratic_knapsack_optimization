% Solve a non singular linear system with LU decomposition and
% backward and forward substitution
%
% @param A: [n x n] real non singular symmetric matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solution of Ax=b
 
function x = solve_LU(A, b)
    [L, U] = LU_fact(A);
    y = forward_sub(L, b);
    x = backward_sub(U, y);
end