function state_tree = DP(n, m)
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
        end
    end
end

end