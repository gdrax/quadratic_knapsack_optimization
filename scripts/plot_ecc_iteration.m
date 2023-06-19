function plot_ecc_iteration()
    n = 99;
    iterations_f = zeros(n, 1);
    for i=1:n
        actv = 0.6;
        ecc = 0.01*i;
        KP = gen_knapsack(100, 0, 1000, actv, ecc);
        [xs, info_f] = ASKP(KP, 10000, 1e-10, 'l', false, false, true);
        iterations_f(i) = info_f.it(end);
    end
    plot(0.01:0.01:0.01*n, iterations_f, LineWidth=1.5);
    legend("ASKP_L")
    xlabel('eccentricity')
    ylabel('n. of iterations')
end