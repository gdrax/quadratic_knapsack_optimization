function table_ecc()
    KP1 = gen_knapsack(100, 0, 10000, 0.6, 0.1);
    xs = ASKP(KP1, 10000, 1e-10, 'l');
    KP2 = gen_knapsack(500, 0, 10000, 0.6, 0.1);
    xs = ASKP(KP2, 10000, 1e-10, 'l');
    KP3 = gen_knapsack(1000, 0, 10000, 0.6, 0.1);
    xs = ASKP(KP3, 10000, 1e-10, 'l');
    
    KP4 = gen_knapsack(100, 0, 10000, 0.6, 0.5);
    xs = ASKP(KP4, 10000, 1e-10, 'l');
    KP5 = gen_knapsack(500, 0, 10000, 0.6, 0.5);
    xs = ASKP(KP5, 10000, 1e-10, 'l');
    KP6 = gen_knapsack(1000, 0, 10000, 0.6, 0.5);
    xs = ASKP(KP6, 10000, 1e-10, 'l');
    
    KP7 = gen_knapsack(100, 0, 10000, 0.6, 0.999);
    xs = ASKP(KP7, 10000, 1e-10, 'l');
    KP8 = gen_knapsack(500, 0, 10000, 0.6, 0.999);
    xs = ASKP(KP8, 10000, 1e-10, 'l');
    KP9 = gen_knapsack(1000, 0, 10000, 0.6, 0.999);
    xs = ASKP(KP9, 10000, 1e-10, 'l');