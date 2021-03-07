classdef StateClass
    properties
        state
        prev_states
        optimal_value
    end
    methods 
        function obj = StateClass(val)
            obj.state = val;
        end
    end
end