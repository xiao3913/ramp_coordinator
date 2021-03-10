%% Program setup
addpath(fullfile(pwd),'src')
%% User defined parameters
v_max = 25; %maximal allowed velocity [m/s] choose between [10 25]
v_min = 0;  %minimal allowed velocity [m/s] choose between [0 v_max]
a_max = 3;  %maximal allowed acceleration [m/s^2] choose between [1.5 5]
a_min = -3; %minimal allowed acceleration [m/s^2] choose between [-5 -1.5]

CR_length = 300; %define the length of the control region [m] 300 is reasonable
n = 7; %number of main road vehicles
m = 4; %number of ramp vehicles

tau = 1; tau_L = 1.5; %specify time headway
%% Initialize the scenario at random given the user parameters

[pos_n, vel_n, time_n] = initialize_vehicle(n, v_max, a_max, CR_length, tau); %initialize vehicles on main road

[pos_m, vel_m, time_m] = initialize_vehicle(m, v_max, a_max, CR_length, tau); %initialize vehcile on ramp

%% Running the optimization and display results
tic 
[state_tree, t_arrival_n, t_arrival_m] = DP(n, m, time_n, time_m, tau, tau_L);
toc

plot(t_arrival_n,'*')
hold on
plot(t_arrival_m,'o')
xlabel('vehicles')
ylabel('arrival time')
legend('main road', 'on ramp')
total_arrival_time = sum(t_arrival_n) + sum(t_arrival_m)
total_delay = sum(t_arrival_n - time_n) + sum(t_arrival_m - time_m)