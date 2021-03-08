classdef DPtest < matlab.unittest.TestCase
    methods(Test)
        function testTotalstage(testCase)
            % test if the DP generate the correct number of stages
            state_tree = DP(3,4);
            actual_totalstage = length(state_tree);
            expected_totalstage = 3+4+1;
            testCase.verifyEqual(actual_totalstage,expected_totalstage)
        end
        function testTotalstate(testCase)
           state_tree = DP(3,5);
           actual_totalstate = 0;
           for i = 1:length(state_tree) 
                actual_totalstate = actual_totalstate + size(state_tree{i},1);
           end
           expected_totalstate = 2*3*5+3+5+1;
           testCase.verifyEqual(actual_totalstate, expected_totalstate)
        end
        function testFinalState(testCase)
           state_tree = DP(7,4);
           actual_finalstate = state_tree{4+7+1}(1).state;
           expected_finalstate = [7 4 1];
           testCase.verifyEqual(actual_finalstate, expected_finalstate)
        end
    end
end