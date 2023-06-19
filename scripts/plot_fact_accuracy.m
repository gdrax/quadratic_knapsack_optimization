function plot_fact_accuracy()
    n = 20;
    normldl = zeros(n, 1);
%     normlu = zeros(n, 1);
    normbp = zeros(n, 1);
    normmatlab = zeros(n, 1);
    for i=1:n
        K = gen_K(50*i);
        [L, D, P] = LDL_pivot(K);
        normldl(i) = norm(P*K*P'-L*D*L');
        [L, D, P] = BP_fact(K);
        normbp(i) = norm(P*K*P'-L*D*L');
        [L, D, P] = ldl(K);
        normmatlab(i) = norm(P'*K*P-L*D*L');
    end
    plot(1:50:n*50, log10(normldl), 1:50:n*50, log10(normbp), 1:50:n*50, log10(normmatlab), LineWidth=1.5);%, 1:50:n*50, log10(normlu),);
    legend("LDL", "BP", "matlab")
    xlabel('n')
    ylabel("||P*A*P'-L*D*L'||")
end