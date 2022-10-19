
clc
clear all


Init_V_Range = 9;
Init_Speed = 20;
Init_Pose = [1 1]; % single array should be fine here
Init_Path = {[2,3], [3,4], [4,5]}; % Use a cell array to store x,y poses
% disp(Init_Path{1})
agent = Agent(Init_V_Range,Init_Speed, Init_Pose, Init_Path);


