function plot_singular_iteration()
    n = 199;
    iterations_f = zeros(n, 1);
    iterations_l = zeros(n, 1);
    for i=1:n
        actv = 0.4;
        ecc = 0.6;
        KP = gen_knapsack(200, i, 1000, actv, ecc);
        [xs, info_f] = ASKP(KP, 10000, 1e-10, 'f', false, false, true);
        [xs, info_l] = ASKP(KP, 10000, 1e-10, 'l', false, false, true);
        iterations_f(i) = info_f.it(end);
        iterations_l(i) = info_l.it(end);
    end
    plot(1:n, iterations_f, 1:n, iterations_l, LineWidth=1.5);
    legend("ASKP_F", "ASKP_L")
    xlabel('n. of zero eigenvalues of K')
    ylabel('n. of iterations')
end