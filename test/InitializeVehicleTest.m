classdef InitializeVehicleTest < matlab.unittest.TestCase
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
        function testVelocityLimit(testCase)
            %test that all randomly generated vehicle velocities are within
            %the Velocity limit
            v_max = 20; a_max = 3; CR_length = 300; tau = 1; num = 6; 
            [~, vel, ~] = initialize_vehicle(num, v_max, a_max, CR_length, tau);
            max_vehicle_vel = max(vel);
            testCase.verifyLessThanOrEqual(max_vehicle_vel, v_max)
        end
        function testPositionLimit(testCase)
            %test that all randomly genereted vehicle position are within
            %the control region [0 CR_length]
            v_max = 20; a_max = 3; CR_length = 300; tau = 1; num = 6;
            [pos, ~, ~] = initialize_vehicle(num, v_max, a_max, CR_length, tau);
            max_vehicle_pos = max(pos);
            min_vehicle_pos = min(pos);
            testCase.verifyLessThanOrEqual(max_vehicle_pos, CR_length)
            testCase.verifyGreaterThanOrEqual(min_vehicle_pos, 0)
        end
    end
end