% Solve a non singular symmetric linear system with LDL decomposition and
% backward and forward substitution
%
% @param A: [n x n] real non singular symmetric matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solution of Ax=b

function x = solve_LDL(A, b)
    [L, D] = LDL_fact(A);
    y = forward_sub(L, b);
    z = y./diag(D);
    x = backward_sub(L', z);
end