classdef ReachableSetTest < matlab.unittest.TestCase
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
        function testUpperClass(testCase)
            %Test if the returned element inside upper_bound is of desired
            %function_handle class
            dist = 10; a_max = 3; a_min = 3; v_max = 25; vel = 18; t_max = 30;
            [~,~, upper_bound,~] = reachable_set(dist, a_max, a_min, v_max, vel,t_max);
            testCase.verifyClass(upper_bound{1}, ?function_handle)
        end
        function testLowerClass(testCase)
            %Test if the returned element inside lower_bound is of desired
            %function_handle class
            dist = 10; a_max = 3; a_min = 3; v_max = 25; vel = 18; t_max = 30;
            [~,~,~,lower_bound] = reachable_set(dist, a_max, a_min, v_max, vel,t_max);
            testCase.verifyClass(lower_bound{1}, ?function_handle)
        end
    end
end