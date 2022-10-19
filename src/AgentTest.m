% Agent Tester File
% Intended to test methods contained in Agent.m
clc
clear all

Init_V_Range = 9;
Init_Speed = 20;
Init_Pose = [1 1]; % single array should be fine here
Init_Path = {[2,3], [3,4], [4,5]}; % Use a cell array to store x,y poses

agent = Agent(Init_V_Range,Init_Speed, Init_Pose, Init_Path);

% disp(agent.Vision_Range); % Passed vision range
% disp(agent.Speed); % Passed speed value
% disp(agent.Current_Path); % Full passed path
% disp(agent.Current_Path{1}); % Index 1 of set path
% disp(agent.Current_Pose); % Current Position
% disp(agent.Time_Step); % Check unadjusted values

agent.SetPose([10 10]);
% disp(agent.GetPose());

agent.SetPath({[2,2], [3,3], [4,4]});
% disp(agent.GetPath());

agent.SetVisionScope();
agent.SetCalculationScope(5);









% Section of shame


% obj.Vision_Current_FOV = deg2rad(fix(((360 - obj.Vision_Min_FOV)/ClosestObjDist^2) + obj.Vision_Min_FOV));
% 
% % obj.Vision_tempx = [cos(((obj.Vision_Current_FOV)/2)) cos(((-obj.Vision_Current_FOV)/2))];
% % obj.Vision_tempy = [sin(((obj.Vision_Current_FOV)/2)) sin(((-obj.Vision_Current_FOV)/2))];
% % obj.Vision_BlackSpace_1 = linspace(-obj.Vision_Current_FOV/2,obj.Vision_Current_FOV/2, 1000);
% % obj.Vision_BlackSpace_2 = linspace(-obj.Vision_Current_FOV/2,-pi);
% 
% % [obj.Vision_tempx, obj.Vision_tempy] = pol2cart(linspace(obj.Vision_Current_FOV, -obj.Vision_Current_FOV, 10000), obj.Vision_Range);
% % [obj.CalcMaskRows, obj.CalcMaskCols] = meshgrid(obj.Vision_tempx, obj.Vision_tempy);

% [obj.Vision_BlackSpace_1, obj.Vision_BlackSpace_2] = pol2cart(obj.Vision_Current_FOV/2,linspace(0,obj.Vision_Range,1000));
% obj.Vision_BlackSpace_1 = unique(round(obj.Vision_BlackSpace_1));
% obj.Vision_BlackSpace_2 = unique(round(obj.Vision_BlackSpace_2));
% obj.Vision_BlackSpace_1 = obj.Vision_BlackSpace_1(obj.Vision_BlackSpace_1~=0);
% obj.Vision_BlackSpace_2 = obj.Vision_BlackSpace_2(obj.Vision_BlackSpace_2~=0);
% 
% % obj.tempstuff = obj.CalcMaskRows + obj.CalcMaskCols;
% 
% % obj.Calc_Cells(1:(obj.Vision_BlackSpace_1 + fix(obj.CalcMaskCols/2)), 1:fix(obj.CalcMaskRows/2)) = 0;
% % disp(obj.Calc_Cells(1:(obj.Vision_BlackSpace_1 + fix(obj.CalcMaskCols/2)), 1:(obj.Vision_BlackSpace_2 + fix(obj.CalcMaskRows/2))));
% % obj.Calc_Cells(1:obj.Vision_BlackSpace_1, fix(obj.CalcMaskRows/2):obj.Vision_BlackSpace_2) = 0;
% 
% % obj.Vision_tempx = cos(((obj.Vision_BlackSpace_1)/2)) * obj.Vision_Range;
% % obj.Vision_tempy = sin(((obj.Vision_BlackSpace_1)/2)) * obj.Vision_Range;
% 
% % indicator = abs(obj.CalcMaskRows.^2 + obj.CalcMaskCols.^2 - obj.Vision_Range^2) < obj.CalcTolerance;
% % obj.CalcXCircle = obj.CalcMaskRows(indicator);
% % obj.CalcYCircle = obj.CalcMaskCols(indicator);
% 
% % Interpret current vision, should call from vision scope
% 




