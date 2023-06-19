function table_knapsack()
    KP1 = gen_knapsack(100, 0, 10);
    xs = ASKP(KP1, 10000, 1e-10, 'l');
    KP2 = gen_knapsack(500, 0, 10);
    xs = ASKP(KP2, 10000, 1e-10, 'l');
    KP3 = gen_knapsack(100, 30, 10);
    xs = ASKP(KP3, 10000, 1e-10, 'l');
    KP4 = gen_knapsack(500, 150, 10);
    xs = ASKP(KP4, 10000, 1e-10, 'l');

    KP1 = gen_knapsack(100, 0, 1000);
    xs = ASKP(KP1, 10000, 1e-10, 'l');
    KP2 = gen_knapsack(500, 0, 1000);
    xs = ASKP(KP2, 10000, 1e-10, 'l');
    KP3 = gen_knapsack(100, 30, 1000);
    xs = ASKP(KP3, 10000, 1e-10, 'l');
    KP4 = gen_knapsack(500, 150, 1000);
    xs = ASKP(KP4, 10000, 1e-10, 'l');
end