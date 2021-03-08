function state_tree = DP(n, m, t_min_n, t_min_m, tau, tau_L)
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
            state_tree{i+1}(index,:).state(3)
            state_tree{i+1}(index,:).state(2)
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

end