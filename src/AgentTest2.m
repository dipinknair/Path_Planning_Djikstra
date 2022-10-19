% Agent Tester File
% Intended to test methods contained in 
% Agent.m and VisionProcess.m
clc
clear all

Init_V_Range = 10;
Init_Speed = 20;
Init_Pose = [1 1]; % single array should be fine here
Init_Path = {[2,3], [3,4], [4,5]}; % Use a cell array to store x,y poses

agent = Agent(Init_V_Range,Init_Speed, Init_Pose, Init_Path);

disp(rad2deg(agent.Vision_Current_FOV));

% figure(2)
% plot(agent.Vision_BlackSpace_1,
% agent.Vision_BlackSpace_2,agent.Vision_BlackSpace_1, -agent.Vision_BlackSpace_2);
% Breaks if a1 and a2 are different
angle = 5/12;
a1 = -angle*pi; 
a2 = angle*pi;
t = linspace(a1,a2,Init_V_Range*4);
x = 0 + agent.Vision_Range*cos(t);
y = 0 + agent.Vision_Range*sin(t);

xtemp = 0 + agent.Vision_Range*cos(a1);
ytemp = 0 + agent.Vision_Range*sin(a1);

% [row, col] = ind2sub(size(agent.Calc_Cells), 1:numel(agent.Calc_Cells));


% numel(col(in))
% plot(row(in),col(in),'r+',[0,x,0],[0,y,0],'y-') % points inside
% figure(3)
p = patch([0,x,0],[0,y,0],'w-');
% axis equal

disp(p.Vertices((end-1):(end),:));
fitPoints = [p.Vertices(1:2,1), p.Vertices(1:2,2);
    p.Vertices((end-1):(end),1), p.Vertices((end-1):(end),2)];

patchFitUp = polyfit(fitPoints(3:4,1),fitPoints(3:4,2),1);
patchXUp = linspace(min(fitPoints(1:2,1)), max(fitPoints(1:2,1)), Init_V_Range*2);
patchYUp = polyval(patchFitUp, patchXUp);

patchFitDown = polyfit(fitPoints(1:2,1),fitPoints(1:2,2),1);
patchXDown = linspace(min(fitPoints(1:2,1)), max(fitPoints(1:2,1)), Init_V_Range*2);
patchYDown = polyval(patchFitDown, patchXUp);

patchX = [patchXUp, patchXDown];
patchY = [patchYUp, patchYDown];

% fitNeg = polyfit(p.Vertices(1:2,1),p.Vertices(1:2,2),1);
% disp(max(max(p.Vertices)));
% disp(unique(round(p.Vertices(:,1))));
% disp(round(p.Vertices(:,1))+ round(max(p.Vertices(:,1)))+1);
% disp(round(p.Vertices(:,2))+ round(max(p.Vertices(:,2)))+1);
% temp = sub2ind(size(agent.Calc_Cells),round(p.Vertices(:,1))+ round(abs(max(p.Vertices(:,1))))+1,round(p.Vertices(:,2))+ round(abs(max(p.Vertices(:,2))))+1);

tempOffset = round(size(agent.Calc_Cells)/2);
temp1 = sub2ind(size(agent.Calc_Cells),round(p.Vertices(:,1)) + tempOffset(1),round(p.Vertices(:,2))+ tempOffset(1));
temp2 = sub2ind(size(agent.Calc_Cells), round(patchX) + tempOffset(1), round(patchY) + tempOffset(1));
tempMat = zeros(size(agent.Calc_Cells));
% [in,on] = inpolygon(x,y,row,col);

temp = [transpose(temp1), temp2];

tempMat(temp) = 1;
% tempMat(temp2) = 1;
tempMat = rot90(tempMat);

elemsMat = numel(agent.Calc_Cells);
[xc, yc] = ind2sub(size(agent.Calc_Cells),temp);
[xq, yq] = ind2sub(size(agent.Calc_Cells),1:elemsMat);

[in, on] = inpolygon(xq, yq, xc, yc);
polyMat = zeros(size(agent.Calc_Cells));
polyMat(in) = 1;

polyMat = rot90(polyMat);

figure(4)
plot(p.Vertices(:,1),p.Vertices(:,2),'*k',patchXDown, patchYDown,'r*', patchXUp, patchYUp,'r*');
axis equal

figure(2)
% subplot(1, 1, 1);
% imshow(tempMat) ;
% plot(tempMat, 'r*');
pcolor(tempMat)
colormap([0 0 0; 1 1 1]);
axis equal

figure(3)
pcolor(polyMat)
colormap([0 0 0; 1 1 1]);
axis equal


