classdef StateClass < handle
    properties
        state
        prev_states
        optimal_value
        optimal_path
    end
    methods 
        function obj = StateClass(val)
            obj.state = val;
        end
        function obj = GetOptimal(obj, t_min, tau, tau_L)
            obj.optimal_path = 0;
            obj.optimal_value = 1000;
            for i = 1:length(obj.prev_states)
                optimal_to_come = obj.prev_states(i).optimal_value;
                if obj.state(3) == obj.prev_states(i).state(3)
                    value = max(t_min, optimal_to_come + tau);
                else
                    if obj.prev_states(i).state(3) == 0
                        value = max(t_min, optimal_to_come);
                    else
                        value = max(t_min, optimal_to_come + tau_L);
                    end
                end
                
                if value < obj.optimal_value
                    obj.optimal_value = value;
                    obj.optimal_path = i;
                end
            end

        end
    end
end