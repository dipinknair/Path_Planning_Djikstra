%%% Project Path planning in dynamic environment 
%%% 12/04/2021
%%% Rémi Cartert

clear all;
close all;
clc;

%%%%%%%%%%%%   Pre-Build Maps    %%%%%%%%%%%%%%%
size_map=30; 
start=[2,2];
goal=[size_map-2,size_map-2];
robot_velocity = 0.6;
angular_velocity=2;

myMap = binaryOccupancyMap(30,30,1);

walls=zeros(size_map,size_map);
walls(1,:)=1; %Top Wall 
walls(end,:)=1; %Bottom wall
walls(:,end)=1; %Right Wall 
walls(:,1)=1; %Left wall
walls(10,1:20)=1; % First wall
walls(20,10:end)=1; %SecondWall


setOccupancy(myMap,[1 1], walls, "grid");
show(myMap), grid on
%%

%%%%%%%%%%%%   Path Planning    %%%%%%%%%%%%
%prm=mobileRobotPRM(myMap); % Path planning algorithm use as an example
%path = findpath(prm,start,goal); %% Path stocks coordinates
path =[[2,2]
[2.02922846254311	2.45522778743892]
[10.8133047978623	14.9385884323775]
[21.8204019933420	17.1779560522911]
[26.8784333886629	24.2014804587514]
[28	28]];
%%
%%%%%%%%%%% Static Obstacle Generation     %%%%%%%%%%%

%%
%%%%%%%%%%% Dynamic Obstacle initialisation V1 %%%%%%%%%
X_Obstacle = 15;        
Y_Obstacle = 8;
VX_Obstacle=1;
VY_Obstacle=1;
Obstacle_lenght=5;
Obstacle_orientation = 0;  %initial obstacle orientation
walls(X_Obstacle,Y_Obstacle:Y_Obstacle+Obstacle_lenght)=1;  % initial obstacle position

%%
%%%%%%%%%%% Dynamic Obstacle initialisation V2 %%%%%%%%%
px=5;
py=5;
t=0;
%%
robotPosition=start;
robotGoal=goal;
goalRadius = 0.05;
distanceToGoal=norm(robotGoal-robotPosition);

% Initialize the simulation loop
sampleTime = 0.1;
vizRate = rateControl(1/sampleTime);

% Initialize the figure
figure


reset(vizRate);

while( distanceToGoal > goalRadius )
    
    % Re-compute the distance to the goal
    %distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal(:));

    %{
    if (Obstacle_orientation==0 && walls(30*X_Obstacle+Y_Obstacle+Obstacle_lenght)==1)
        Obstacle_orientation=180;
    end
    if (Obstacle_orientation==180 && walls(30*X_Obstacle+Y_Obstacle)==1)
        Obstacle_orientation=0;
    end
    %}
    %%{
    if (Obstacle_orientation==0 && Y_Obstacle+Obstacle_lenght==29)
        Obstacle_orientation=180;
    end
    if (Obstacle_orientation==180 && +Y_Obstacle==2)
        Obstacle_orientation=0;
    end
    %}

    previousX=X_Obstacle;
    PreviousY=Y_Obstacle;
    %X_Obstacle = X_Obstacle+VX_Obstacle*cosd(Obstacle_orientation); 
    Y_Obstacle = Y_Obstacle+VY_Obstacle*cosd(Obstacle_orientation);
    walls(previousX,PreviousY:PreviousY+Obstacle_lenght)=0;  % initial obstacle position
    walls(X_Obstacle,Y_Obstacle:Y_Obstacle+Obstacle_lenght)=1;  % initial obstacle position
    setOccupancy(myMap,[1 1], walls, "grid");

    % Update the plot
    hold off
    show(myMap);
    hold all

    waitfor(vizRate);
end


% moving point
%{
    dx = 0.5*cosd(t);      % how fast we move
    dy = 0.5*sind(t);
    if ((px>25) || (px<5))
        t=t+160;
    end
    if ((py>25) || (py<5))
        t=t+160;
    end
    plot(start(1),start(2),'.g');
    plot(goal(1),goal(2),'.r');
    
    plot([px px+dx]', [py py+dy]')      % plot displacement
    px = px + dx;                       % new position
    py = py + dy;
    h = plot(px,py,'.b');               % plot new position
    %pause(0.2)                          % wait
    %delete(h)                           % remove new position
                                        % from graph
    dx = 1*cosd(t);      % how fast we move
    dy = 1*sind(t);
    %t = t + 90*(0.5-rand(size(px)));    % change direction (-45:45) degree

%}