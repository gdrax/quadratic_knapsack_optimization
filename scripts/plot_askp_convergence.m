function plot_askp_convergence()
    KP = gen_knapsack(200, 0, 1000, 0.6, 0.6);
    [xs, info] = ASKP(KP, 10000, 1e-10, 'f', true, false, true);
%     [xs, info] = ASKP(KP, 10000, 1e-10, 'l', false, false, true);
    plot(info.it(2:end), log10(info.vgap(2:end)), LineWidth=1.5);
%     plot(info.it(2:end), info.vgap(2:end), LineWidth=1.5);
    legend("ASKP_L")

    ylabel('||f(x*)-f(x)||')
    xlabel('n. of iterations')
end