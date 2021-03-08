clear all
m = 3;
n = 3;

state_tree{n+m+1} = [];
state_tree{1} = [0 0 0];
for i = 1:n+m
    lower = max(0,i-n);
    upper = min(i,n);
    for j = lower:upper
        if j == 0
            state_tree{i+1} = [state_tree{i+1}; [j i-j 2]];
        elseif i-j == 0
            state_tree{i+1} = [state_tree{i+1}; [j i-j 1]];
        else
            state_tree{i+1} = [state_tree{i+1}; [j i-j 1]];
            state_tree{i+1} = [state_tree{i+1}; [j i-j 2]];
        end
    end
end