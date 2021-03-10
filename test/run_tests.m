import matlab.unittest.TestSuite
suite1 = TestSuite.fromFile('DPtest.m');
suite2 = TestSuite.fromFile('ReachableSetTest.m');
totalSuite = [suite2];
totalResult = run(totalSuite);
disp(totalResult)
