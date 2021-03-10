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
        function testSizeUpper(testCase)
            %Test if the returned number of time intervals matches with the returned number of 
            %function handles for the upper bound case, They should math one by one
            dist = 10; a_max = 3; a_min = 3; v_max = 25; vel = 18; t_max = 30;
            [tu_interval,~, upper_bound,~] = reachable_set(dist, a_max, a_min, v_max, vel,t_max);
            expected_size = size(tu_interval);
            testCase.verifySize(upper_bound,expected_size)
        end
        function testSizeLower(testCase)
            %Test if the returned number of time intervals matches with the returned number of 
            %function handles for the lower bound case, They should math one by one
            dist = 10; a_max = 3; a_min = 3; v_max = 25; vel = 18; t_max = 30;
            [~,tl_interval,~,lower_bound] = reachable_set(dist, a_max, a_min, v_max, vel,t_max);
            expected_size = size(tl_interval);
            testCase.verifySize(lower_bound,expected_size)
        end
        function testUpperFunctionHandle(testCase)
            %Test if the upper bound function handle return the correct
            %number of values given the corresponding time interval input
            dist = 10; a_max = 3; a_min = 3; v_max = 25; vel = 18; t_max = 30;
            [tu_interval,~, upper_bound,~] = reachable_set(dist, a_max, a_min, v_max, vel,t_max);
            dt = 0.001;
            for i=1:length(tu_interval)
                t1 = tu_interval{i}(1);
                t2 = tu_interval{i}(2);
                expected_size = size([t1:dt:t2]);
                testCase.verifySize(upper_bound{i}([t1:dt:t2]),expected_size)             
            end         
        end
        function testLowerFunctionHandle(testCase)
            %Test if the upper bound function handle return the correct
            %number of values given the corresponding time interval input
            dist = 10; a_max = 3; a_min = 3; v_max = 25; vel = 18; t_max = 30;
            [~,tl_interval,~,lower_bound] = reachable_set(dist, a_max, a_min, v_max, vel,t_max);
            dt = 0.001;
            for i=1:length(tl_interval)
                t1 = tl_interval{i}(1);
                t2 = tl_interval{i}(2);
                expected_size = size([t1:dt:t2]);
                testCase.verifySize(lower_bound{i}([t1:dt:t2]),expected_size)             
            end         
        end
    end
end