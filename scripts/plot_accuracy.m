function plot_accuracy()
    n = 20;
    normldl = zeros(n, 1);
    normlu = zeros(n, 1);
    normbp = zeros(n, 1);
    normmatlab = zeros(n, 1);
    for i=1:n
        [K, b] = gen_posdef(50*i);
        [L, D, P] = LDL_pivot(K);
        x = solve_LDL(K, b);
        normldl(i) = norm(K*x-b);
        [L, D, P] = BP_fact(K);
        x = solve_BP(K, b);
        normbp(i) = norm(K*x-b);
        x = K \ b;
        normmatlab(i) = norm(K*x-b);
    end
    plot(1:50:n*50, log10(normldl), 1:50:n*50, log10(normbp), 1:50:n*50, log10(normmatlab), LineWidth=1.5);%, 1:50:n*50, log10(normlu),);
    legend("LDL", "BP", "matlab")
    xlabel('n')
    ylabel('||Ax-b||')
end