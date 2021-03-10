classdef StateClassTest < matlab.unittest.TestCase
    %This class are intented write test cases for StateClass.m
    properties
        OriginalPath
    end
    methods (TestMethodSetup)
        function addDPtoPath(testCase)
            testCase.OriginalPath = path;
            mydir = pwd;
            idcs   = strfind(pwd,'\');
            newdir = mydir(1:idcs(end)-1);
            addpath(fullfile(newdir))
        end
    end
    methods (TestMethodTeardown)
        function restorePath(testCase)
            path(testCase.OriginalPath);
        end
    end
    methods(Test)
        function testPrevStatesClass(testCase)
            %test that same class object can be assigned as property to
            %that class object
            state = StateClass([2 3 1]);
            state.prev_states = StateClass([0 0 0]);
            testCase.verifyClass(state.prev_states, 'StateClass')
        end
        function testOptimalValue(testCase)
            %test if the GetOptimal function will return the correct
            %optimal value based on the optimal value from a previous state
            %expected state.optimal_value = max(t_min, prev_state.optimal_value+tau)
            t_min = 10;
            tau = 1;
            tau_L = 1.5;
            prev_state = StateClass([0 0 0]);
            prev_state.optimal_value = 1;
            state = StateClass([2 3 1]);
            state.prev_states = prev_state;
            state.GetOptimal(t_min, tau, tau_L);
            testCase.verifyEqual(state.optimal_value,10)
        end
        function testOptimalPath(testCase)
            %test if the GetOptimal function will return the correct
            %optimal path from 2 previou states will different previous
            %optimal value, it should return the path that lead to less
            %value. 
            prev_state1 = StateClass([0 0 0]);
            prev_state1.optimal_value = 1;
            prev_state2 = StateClass([0 0 0]);
            prev_state2.optimal_value = 100;
            state = StateClass([2 3 1]);
            state.prev_states = [prev_state1; prev_state2];
            state.GetOptimal(10, 1, 1.5)
            testCase.verifyEqual(state.optimal_path,1)
        end
    end
end