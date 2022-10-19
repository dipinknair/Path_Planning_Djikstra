function [Obstacle] = ObstacleGen(mapSize, obstacleSelect)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

scaleFactorSelect = 2;
% obstacleSelect = 3;
minScaleFactor = 2;
Obstacle = [];
scaleFactor = [floor(sqrt(mapSize)/20),floor(sqrt(mapSize)/10), floor(sqrt(mapSize)/5)]; % [Small, Med, Large]

switch obstacleSelect
    case 1 % Block Obstacle
        blockObstacle = ones(2+scaleFactor);
        % Obstacle = [Obstacle, blockObstacle];
        Obstacle = blockObstacle;
    case 2 % Long Obstacle
        numRows = 4 + scaleFactor(scaleFactorSelect);
        numCols = 1 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/2);
        longObstacle = ones([numRows, numCols]);
        Obstacle = longObstacle;
    case 3 % L Obstacle
        numRows = 3 + scaleFactor(scaleFactorSelect);
        numCols = 2 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/2);
        L_Obstacle = ones([numRows, numCols]);
        L_Obstacle((2 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/10)):end,2 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/10):end) = 0;
        Obstacle = L_Obstacle;
    case 4 % J Obstacle
        numRows = 3 + scaleFactor(scaleFactorSelect);
        numCols = 2 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/2);
        J_Obstacle = ones([numRows, numCols]);
        J_Obstacle((2 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/10)):end,1:(end-(1 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/10)))) = 0;
        Obstacle = J_Obstacle;
    case 5 % S Obstacle
        numRows = 3 + scaleFactor(scaleFactorSelect);
        numCols = 2 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/2);
        S_Obstacle = ones([numRows, numCols]);
        S_Obstacle(1:1+floor(scaleFactor(scaleFactorSelect)/2.5),1:1+floor(scaleFactor(scaleFactorSelect)/3)) = 0;
        S_Obstacle((end - floor(scaleFactor(scaleFactorSelect)/2.5)):end,(end - floor(scaleFactor(scaleFactorSelect)/3)):end) = 0;
        Obstacle = S_Obstacle;
    case 6 % Z Obstacle
        numRows = 3 + scaleFactor(scaleFactorSelect);
        numCols = 2 + floor((scaleFactor(scaleFactorSelect) - minScaleFactor)/2);
        Z_Obstacle = ones([numRows, numCols]);
        Z_Obstacle((end - floor(scaleFactor(scaleFactorSelect)/2.5)):end,1:1+floor(scaleFactor(scaleFactorSelect)/3)) = 0;
        Z_Obstacle(1:1+floor(scaleFactor(scaleFactorSelect)/2.5),(end - floor(scaleFactor(scaleFactorSelect)/3)):end) = 0;
        Obstacle = Z_Obstacle;
    otherwise
        Obstacle = 1;
        
end

% blockObstacle(1,1) = 0;
% blockObstacle(2,2) = 0;

% obstacleList = blockObstacle;

end

