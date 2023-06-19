function plot_kernel_accuracy()
    n = 20;
    normldl = zeros(n, 1);
%     normlu = zeros(n, 1);
    normbp = zeros(n, 1);
    normmatlab = zeros(n, 1);
    for i=1:n
        K = gen_possemidef(50*i, 49*i);
        [L, D, P] = LDL_pivot(K);
        N = LDL_kernel(L, D, P);
        normldl(i) = norm(K*N(:, 1));
%         [L, U] = LU_pivot(K);
%         N = LU_kernel(L, U);
%         normlu(i) = norm(z-K*N);
        [L, D, P] = BP_fact_stop(K);
        N = BP_kernel_first(L, D, P);
        normbp(i) = norm(K*N);
        N = null(K);
        normmatlab(i) = norm(K*N(:, 1));
    end
    plot(1:50:n*50, log10(normldl), 1:50:n*50, log10(normbp), 1:50:n*50, log10(normmatlab), LineWidth=1.5);%, 1:50:n*50, log10(normlu),);
    legend("LDL", "BP", "matlab")
    xlabel('n')
    ylabel('||Av||')
end