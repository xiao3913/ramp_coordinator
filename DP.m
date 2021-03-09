function [state_tree, t_arrival_n, t_arrival_m] = DP(n, m, t_min_n, t_min_m, tau, tau_L)
% DP.m is the implementation of Dynamic Programming algorithm
% Inputs:
%   n : number of mainroad vehicles
%   m : number of ramp vehicles
%
% Output:
%   state_tree : the tree structure representing states at each stage and
%   transition between states

state_tree{n+m+1} = [];
state_tree{1} = StateClass([0 0 0]);
state_tree{1}(1).optimal_value = 0;
for i = 1:n+m
    lower = max(0,i-m);
    upper = min(i,n);
    index = 0;
    for j = lower:upper
        if j == 0
            index = index + 1;
            state_tree{i+1} = [state_tree{i+1}; StateClass([j i-j 2])];
            if i-j-1 == 0
                prev_state = [0 0 0];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
            else
                prev_state = [j i-j-1 2];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
            end
            if state_tree{i+1}(index,:).state(3) == 1
                state_tree{i+1}(index,:).GetOptimal(t_min_n(state_tree{i+1}(index,:).state(1)), tau, tau_L);
            else
                state_tree{i+1}(index,:).GetOptimal(t_min_m(state_tree{i+1}(index,:).state(2)), tau, tau_L);
            end
        elseif i-j == 0
            index = index + 1;
            state_tree{i+1} = [state_tree{i+1}; StateClass([j i-j 1])];
            if j-1 == 0
                prev_state = [0 0 0];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
            else
                prev_state = [j-1 i-j 1];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
            end
            if state_tree{i+1}(index,:).state(3) == 1
                state_tree{i+1}(index,:).GetOptimal(t_min_n(state_tree{i+1}(index,:).state(1)), tau, tau_L);
            else
                state_tree{i+1}(index,:).GetOptimal(t_min_m(state_tree{i+1}(index,:).state(2)), tau, tau_L);
            end
        else
            index = index + 1;
            state_tree{i+1} = [state_tree{i+1}; StateClass([j i-j 1])];
            if j-1 == 0
                prev_state = [j-1 i-j 2];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
            else
                prev_state = [j-1 i-j 1];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
                prev_state = [j-1 i-j 2];
                state_tree{i+1}(index,:).prev_states = [state_tree{i+1}(index,:).prev_states; findobj(state_tree{i},'state',prev_state)];
            end
            if state_tree{i+1}(index,:).state(3) == 1
                state_tree{i+1}(index,:).GetOptimal(t_min_n(state_tree{i+1}(index,:).state(1)), tau, tau_L);
            else
                state_tree{i+1}(index,:).GetOptimal(t_min_m(state_tree{i+1}(index,:).state(2)), tau, tau_L);
            end
            
            index = index + 1;
            state_tree{i+1} = [state_tree{i+1}; StateClass([j i-j 2])];
            if i-j-1 == 0
                prev_state = [j i-j-1 1];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
            else
                prev_state = [j i-j-1 1];
                state_tree{i+1}(index,:).prev_states = findobj(state_tree{i},'state',prev_state);
                prev_state = [j i-j-1 2];
                state_tree{i+1}(index,:).prev_states = [state_tree{i+1}(index,:).prev_states; findobj(state_tree{i},'state',prev_state)];
            end
            if state_tree{i+1}(index,:).state(3) == 1
                state_tree{i+1}(index,:).GetOptimal(t_min_n(state_tree{i+1}(index,:).state(1)), tau, tau_L);
            else
                state_tree{i+1}(index,:).GetOptimal(t_min_m(state_tree{i+1}(index,:).state(2)), tau, tau_L);
            end
            
        end
    end
end

t_arrival_n = zeros(n,1);
t_arrival_m = zeros(m,1);
if state_tree{m+n+1}(1).optimal_value < state_tree{m+n+1}(2).optimal_value
    last_state = state_tree{m+n+1}(1);
    path = state_tree{m+n+1}(1).optimal_path;
    t_arrival_n(n)= state_tree{m+n+1}(1).optimal_value;
else
    last_state = state_tree{m+n+1}(2);
    path = state_tree{m+n+1}(2).optimal_path;
    t_arrival_m(m)= state_tree{m+n+1}(2).optimal_value;
end
for k = m+n:-1:2
    last_state = last_state.prev_states(path);
    if last_state.state(3) == 1
        t_arrival_n(last_state.state(1)) = last_state.optimal_value;
    elseif last_state.state(3) == 2
        t_arrival_m(last_state.state(2)) = last_state.optimal_value;
    end
    path = last_state.optimal_path;
end

end