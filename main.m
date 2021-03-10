tic 
[state_tree, t_arrival_n, t_arrival_m] = DP(n, m, t_min_n, t_min_m, tau, tau_L);
toc

plot(t_arrival_n,'*')
hold on
plot(t_arrival_m,'o')
xlabel('vehicles')
ylabel('arrival time')
legend('main road', 'on ramp')
total_arrival_time = sum(t_arrival_n) + sum(t_arrival_m)
total_delay = sum(t_arrival_n - t_min_n) + sum(t_arrival_m - t_min_m)