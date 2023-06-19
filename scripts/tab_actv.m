function tab_actv()
    KP1 = gen_knapsack(500, 0, 100000, 0.1, 0.1);
    [xs, info] = ASKP(KP1, 10000, 1e-10, 'l', false, false, true);
    [xs, info_f] = ASKP(KP1, 10000, 1e-10, 'f', false, false, true);
    [xs, info_f] = ASKP(KP1, 10000, 1e-10, 'f', true, false, true); %ASKP_m

    KP2 = gen_knapsack(500, 0, 100000, 0.5, 0.1);
    [xs, info] = ASKP(KP2, 10000, 1e-10, 'l', false, false, true);
    [xs, info_f] = ASKP(KP2, 10000, 1e-10, 'f', false, false, true);
    [xs, info_f] = ASKP(KP2, 10000, 1e-10, 'f', true, false, true); %ASKP_m


    KP3 = gen_knapsack(500, 0, 100000, 0.9, 0.1);
    [xs, info] = ASKP(KP3, 10000, 1e-10, 'l', false, false, true);
    [xs, info_f] = ASKP(KP3, 10000, 1e-10, 'f', false, false, true);
    [xs, info_f] = ASKP(KP3, 10000, 1e-10, 'f', true, false, true); %ASKP_m

end