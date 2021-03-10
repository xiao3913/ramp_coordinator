import matlab.unittest.TestSuite
suite1 = TestSuite.fromFile('DPtest.m');
suite2 = TestSuite.fromFile('ReachableSetTest.m');
suite3 = TestSuite.fromFile('StateClassTest.m');
suite4 = TestSuite.fromFile('InitializeVehicleTest.m');
totalSuite = [suite2 suite3 suite3];
totalResult = run(totalSuite);
disp(totalResult)
