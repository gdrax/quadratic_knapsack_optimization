function plot_actv_iteration()
    n = 99;
    gap = zeros(n, 1);
    gap_f = zeros(n, 1);
    for i=1:n
        actv = 0.01*i;
        ecc = 0.1;
        KP = gen_knapsack(500, 0, 100000, actv, ecc);
        [xs, info] = ASKP(KP, 10000, 1e-10, 'l', false, false, true);
        [xs, info_f] = ASKP(KP, 10000, 1e-10, 'f', false, false, true);
        gap(i) = info.it(end);
        gap_f(i) = info_f.it(end);
%         gap(i) = norm(KP.xs-xs);
    end
    plot(1:99, gap, 1:99, gap_f, LineWidth=1.5);
    legend("ASKP_L", "ASKP_m")
    xlabel('% of active constraints')
    ylabel('n. of iterations')
end