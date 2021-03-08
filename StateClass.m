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
    end
end