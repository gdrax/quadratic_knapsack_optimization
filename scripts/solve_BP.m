% Solve a non singular symmetric linear system with Bunch-Parlett decomposition and
% backward and forward substitution
%
% @param A: [n x n] real non singular symmetric matrix
% @param b: [n x 1] real vector
%
% @return x: [n x 1] real vector, the solution of Ax=b

function x = solve_BP(A, b)
    [L, D, P] = BP_fact(A);
    y = forward_sub(L, P*b);
    z = solve_block_diag(D, y);
    x = backward_sub(L', z);
    x = (x'*P)';
%     x = P'*x;
end