% D*

% Environment Variables
clc;
clear all;

n = 70; % Size of environment
Environment = zeros(n,n); % Blank Playing Environment
Environment(1,1) = 100;
Environment(1,2) = 50;
figure(1)
h = surf(Environment);
view(2)

pause(5);
disp("updated");

Environment(10,10) = 100;
Environment(10,20) = 50;

set(h,'zdata',Environment);
drawnow


