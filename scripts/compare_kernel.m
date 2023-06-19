%rivedere
function compare_kernel(n)
    A = gen_possemidef(n);
    [L, D, P] = LDL_pivot(A);
    [Lb, Db, Pb] = BP_fact(A);
    [L1, U] = LU_fact(A);
    n = null(A);
    N = LDL_kernel(L, D);
    N1 = LU_kernel(L1, U);
    Nb = LDL_kernel(Lb, Db);
    disp("matlab:")
    disp(norm(A*n))
    disp("LU pivot:")
    disp(norm(A*N1))
    disp("LDL pivot:")
    disp(norm(A*P'*N))
    disp("BP:")
    disp(norm(A*Pb'*Nb))