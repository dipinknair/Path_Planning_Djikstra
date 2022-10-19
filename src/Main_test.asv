

%% Clear the environment and the command line
clear;
close all;
clc;

%% Initialize the maps, color maps, start points and destination points
map_size = [30, 30];
input_map = false(map_size);              % Create an Input Map

input_map (6:7, 8:9) = 1;           % Add an obstacle
input_map (6:9, 12) = 1;            % Add another obstacle
input_map (12, 5:10) = 1;           % Add another obstacle
input_map (13:14, 13:16) = 1;       % Add another obstacle
input_map (16:18, 6:8) = 1;         % Add another obstacle
input_map (4:6, 17:18) = 1;         % Add another obstacle

start_coords = [2, 2];              % Save the location of start coordinate
dest_coords = [30, 30];             % Save location of destination coordinate

drawMapEveryTime = true;            % To see how nodes expand on the grid

cmap = [1   1   1;                  % Create a color map
    0   0   0;
    1   0   0;
    0   0   1;
    0   1   0;
    1   1   0;
    0.5 0.5 0.5];

colormap(cmap);                     % Sets the colormap for the current figure
[nrows, ncols] = size(input_map);   % Save the size of the input_map

map = zeros(nrows,ncols);           % Create map to save the states of each grid cell
map(~input_map) = 1;                % Mark free cells on map
map(input_map) = 2;                 % Mark obstacle cells on map

start_node = sub2ind(size(map), start_coords(1), start_coords(2));      % Generate linear indices of start node
dest_node = sub2ind(size(map), dest_coords(1), dest_coords(2));         % Generate linear indices of dest node

map(start_node) = 5;                % Mark start node on map
map(dest_node) = 6;                 % Mark destination node on map

parent = zeros(nrows, ncols);           % Create a map for holding parent's index for each grid cell

% Update the values of all grid pixels for distance from end
[X, Y] = meshgrid(1:ncols, 1:nrows);
xd = dest_coords(1);
yd = dest_coords(2);
distanceFromEnd = abs(X - yd) + abs(Y - xd);    % Manhattan Distance

image([0.5, map_size(1)-0.5], [0.5, map_size(2)-0.5], map);
ax = gca;
ax.YTick = 0:1:map_size(1);
ax.XTick = 0:1:map_size(2);
grid on;                        % Display grid lines
% drawnow limitrate nocallbacks;  % Update figure
drawnow;
[path,route] = Dstar(input_map, start_coords, dest_coords, false);%% Process the map to update the parent information and distance from start
counter = 2; % starts agent from second value of route since first is the start itself
current = start_node;

obs1x1 = 13;
obs1x2 = 14;
obs1y1 = 13;
obs1y2 = 16;
%robot start moving
while true
    if (current == dest_node)
        break
    end
    %scan from current_dest
    %dynamic environment
    % testing a horizontal object
    if current == current
        map(obs1x1:obs1x2, obs1y1:obs1y2) = 1;
        flag = 0;
        while flag == 0
            id = round(2*rand())-1;
            ij = round(2*rand())-1;
            flag=1;
            for  i = (obs1x1+id):(obs1x2+id)
                for j =(obs1y1+ij):(obs1y2+ij)
                    if map(i,j) == 2
                        flag =0;
                    end
                end
            end
        end
    end
    map(obs1x1+id:obs1x2+id, obs1y1+ij:obs1y2+ij) = 2;
    obs1x1 = obs1x1+id;
    obs1x2 = obs1x2+id;
    obs1y1 = obs1y1+ij;
    obs1y2 = obs1y2+ij;
    %input_map update happened

    %agent scans and detect obstacle his path or not

    %if obstacle
    if map(route(counter))==2
          starttemp = current;
          goaltemp = %from agent
          %[temppath, temproute] = Dstar()
    %reroute
    %if reroute reaches the any of inital path cell
    %update the route
    %continue from that to dest_node
    %else if not reaches
    %scan again and repeat

    %else continue same path
    current =  route(counter);
    map(current) = 7; %covered area
    counter = counter+1;  %next cell on route

    %visualization
    pause(0.5);                   % Pause the code for a while
    image([0.5, map_size(1)-0.5], [0.5, map_size(2)-0.5], map);
    ax = gca;
    ax.YTick = 0:1:map_size(1);
    ax.XTick = 0:1:map_size(2);
    grid on;                        % Display grid lines
    % drawnow limitrate nocallbacks;  % Update figure
    drawnow;



end
