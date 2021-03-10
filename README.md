# Ramp Coordinator Project

## Table of Contents
   * [What is this?](#what-is-this)
   * [Requirements](#requirements)
   * [How to use](#how-to-use)
   * [Testing](#testing)

## What is this?
This project studies the ramp coordination problem for Autonomous Vehicles(AVs) on highway approaching
a certain conflict merging region. The coordination of AVs are formulated as an optimization problem,
where the passiong order of vehicles and their arrival times are determined in order to maximize the traffic flow.

The optimization problem is solved by Dynamic programming and MILP solvers.

## Requirements
1. *Matlab*
2. For future developement *mpt* tool box will be needed

## How to use   
To run the code, simply go into main.m file and adjust the number of vehicles for the traffic scenario by changing variable *m* and *n*.
The program will randomized a initial setup of the vehicles and use dynamic programming to solve the problem.

## Testing
For testing of a function, create a seperate testfile for each function and define testcases within each testfile, include all tests to be
in the *run_test.m* for test running.
