%% Clear the environment and the command line
clear;
close all;
clc;

%% Initialise map %%
nrows=30;
ncols=30;
map_size = [nrows, ncols];
input_map=false(30,30);
size_map=30;
map = zeros(nrows,ncols);           % Create map to save the states of each grid cell

%% Initialise Walls %%
input_map(1,:)=1; %Top Wall
input_map(end,:)=1; %Bottom wall
input_map(:,end)=1; %Right Wall
input_map(:,1)=1; %Left wall


%% Initialise Static Obstacle %%
input_map(round(nrows/3),1:round(2*ncols/3))=1; % Horizontal Wall
input_map(round(nrows/2):end,round(ncols/3))=1; % Vertical Wall
input_map(4:7, 8:9) = 1;           % Add an obstacle

input_map(13:14, 13:16) = 1;       % Add another obstacle
input_map(16:18, 6:8) = 1;         % Add another obstacle
input_map(4:6, 17:18) = 1;         % Add another obstacle


%% Initiniat  Robot Position
start_coords = [nrows-2, 2];              % Save the location of start coordinate
dest_coords = [2, 2];             % Save location of destination coordinate

start_node = sub2ind(size(map), start_coords(1), start_coords(2));      % Generate linear indices of start node
dest_node = sub2ind(size(map), dest_coords(1), dest_coords(2));         % Generate linear indices of dest node

%% Color MAP
%drawMapEveryTime = true;            % To see how nodes expand on the grid
cmap = [1   1   1;                  % Create a color map
    0   0   0;                      % 7 different color values
    1   0   0;
    0   0   1;
    0   1   0;
    1   1   0;
    0.5 0.5 0.5];
colormap(cmap);                     % Sets the colormap for the current figure

%% Initiate Dynamic Obstacle initialisation V1 %%
%Obstacleliste      Obst 1          Obst2
%Y_Obstacle = [round(2*size_map/4) round(size_map/2)] ;
%X_Obstacle = [round(size_map/2) round(3*size_map/4)];
Y_Obstacle = [11 6] ;
X_Obstacle = [15 12];
V_Obstacle=1;
Obstacle_lenght=[7 2];
Obstacle_orientation = [0 90];  %initial obstacle orientation
nb_obstacles=numel(Y_Obstacle);
PreviousX=Y_Obstacle;
PreviousY=X_Obstacle;

%% Initialize the simulation loop
sampleTime = 0.1;
vizRate = rateControl(1/sampleTime);


reset(vizRate);
while(start_node ~= dest_node )

    for i = 1:nb_obstacles
        %Movement among X
        if (Obstacle_orientation(i)==0 || Obstacle_orientation(i)==180)
            if (input_map(Y_Obstacle(i),X_Obstacle(i)+Obstacle_lenght(i)+1)==1)
                Obstacle_orientation(i)=180;
            end
            if (input_map(Y_Obstacle(i),X_Obstacle(i)-1)==1)
                Obstacle_orientation(i)=0;
            end
            X_Obstacle(i) = X_Obstacle(i)+V_Obstacle*cosd(Obstacle_orientation(i));
            input_map(PreviousY(i),PreviousX(i):PreviousX(i)+Obstacle_lenght(i))=0;  % erase last obstacle position
            input_map(Y_Obstacle(i),X_Obstacle(i):X_Obstacle(i)+Obstacle_lenght(i))=1;  % new obstacle position
        end

        %Movement among Y
        if (Obstacle_orientation(i)==90 || Obstacle_orientation(i)==-90)
            test='loop Y';
            if(input_map(Y_Obstacle(i)+Obstacle_lenght(i)+1,X_Obstacle(i))==1)
                Obstacle_orientation(i)=-90;
            end
            if (input_map(Y_Obstacle(i)-1,X_Obstacle(i))==1)
                Obstacle_orientation(i)=90;
            end
            Y_Obstacle(i) = Y_Obstacle(i)+V_Obstacle*sind(Obstacle_orientation(i));
            input_map(PreviousY(i):PreviousY(i)+Obstacle_lenght(i),PreviousX(i))=0;  % erase last obstacle position
            input_map(Y_Obstacle(i):Y_Obstacle(i)+Obstacle_lenght(i),X_Obstacle(i))=1;  % new obstacle position
        end

        PreviousX(i)=X_Obstacle(i);
        PreviousY(i)=Y_Obstacle(i);
    end
    map(~input_map) = 1;                % Mark free cells on map
    map(input_map) = 2;                 % Mark obstacle cells on map
    map(start_node) = 5;                % Mark start node on map
    map(dest_node) = 6;                 % Mark destination node on map

    [path,route] = Dstar(input_map, start_coords, dest_coords, false);%% Process the map to update the parent information and distance from start
    counter = 2;
    current = start_node;

    waitfor(vizRate);

    while true
        if (current == dest_node)
            break
        end
        %else continue same path
        current =  route(counter);
        map(current) = 7; %covered area
        counter = counter+1;  %next cell on route

        %%%%%   visualization   %%%
        image([0.5, map_size(1)-0.5], [0.5, map_size(2)-0.5], map);
        ax = gca;
        ax.YTick = 0:1:map_size(1);
        ax.XTick = 0:1:map_size(2);
        xlabel('X Axis')
        ylabel('Y Axis')
        title("Path Planning using D* in a dynamic Environment")
        %legend("")
        grid on;                        % Display grid lines
        drawnow;
    end
    start_coords=[path(2,1) path(2,2)];
    start_node = sub2ind(size(map), start_coords(1), start_coords(2));
end
