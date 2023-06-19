% Shows accuracy and computing time of different types of factorization
% used to solve a symmetric positive definite linear system Ax = b.

% @param n: positive integer, the szie of the linear system.
% @return x: [n x 1] the solution of the linear system.

function x = compare_factorization(n)
    [K, b] = gen_posdef(n);
    disp("Matlab:")
    tic; x = K \ b; toc;
    disp(norm(K*x-b))
    disp("LU factorization with pivot:")
    tic; x = solve_LU_pivot(K, b); toc;
    disp(norm(K*x-b))
    disp("LDL factorization with pivot:")
    tic; x =solve_LDL_pivot(K, b); toc;
    disp(norm(K*x-b))
    disp("BP algorithm:")
    tic; x = solve_BP(K, b); toc;
    disp(norm(K*x-b))
end