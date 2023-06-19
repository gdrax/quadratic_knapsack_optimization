function plot_time()
    n = 10;
    timeldl = zeros(n, 1);
    timebp = zeros(n, 1);
%     timematlab = zeros(n, 1);
    for i=1:n
        [K, b] = gen_K(50*i);
        tic;
        solve_LDL_pivot(K, b);
        timeldl(i) = toc;
        tic;
        solve_BP(K, b);
        timebp(i) = toc;
%         tic;
%         K \ b;
%         timematlab(i) = toc;
    end
    plot(1:50:n*50, timeldl, 1:50:n*50, timebp, 'LineWidth', 1.5);
    legend("LDL", "BP")
    xlabel('n')
    ylabel('time (s)')
end