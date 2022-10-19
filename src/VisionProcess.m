function [calcSpace] = VisionProcess(angle,range, vision, calc,Viz)
% Process current vision space to obtain desired
% calculation space
%   INPUTS
    % angle = current FOV from agent object
    % range = desired sensor "range" 
    % vision = logical matrix of current obstructions set to 0 within the
    % full, unprocessed vision
    %   1 indicates location available for path
    %   0 indicates obstruction or edge of vision
%   OUTPUTS
    % calcSpace = logical matrix of desired calculation space
    %   1 indicates location available for path
    %   0 indicates obstruction or edge of vision
    % calcEdge = logical matrix of outer edge of desired calculation space
    %   1 indicates location available for path
    %   0 indicates obstruction or edge of vision

% Breaks if a1 and a2 are different values, assuming rads
a1 = -angle; 
a2 = angle;
t = linspace(a1,a2,range*50);

x = range*cos(t);
y = range*sin(t);

% gets a suface with edge points to be used
p = patch([0,x,0],[0,y,0],'w-');

% grabs [0,0] and the two ends of the partial circle
fitPoints = [p.Vertices(1:2,1), p.Vertices(1:2,2);
    p.Vertices((end-1):(end),1), p.Vertices((end-1):(end),2)];

% Creates a line between [0,0] and the two ends, 
% must be split between upper and lower to work with polyval
patchFitUp = polyfit(fitPoints(3:4,1),fitPoints(3:4,2),1);
patchXUp = linspace(min(fitPoints(1:2,1)), max(fitPoints(1:2,1)), range*10);
patchYUp = polyval(patchFitUp, patchXUp);

patchFitDown = polyfit(fitPoints(1:2,1),fitPoints(1:2,2),1);
patchXDown = linspace(min(fitPoints(1:2,1)), max(fitPoints(1:2,1)), range*10);
patchYDown = polyval(patchFitDown, patchXUp);

%combine values
patchX = [patchXUp, patchXDown];
patchY = [patchYUp, patchYDown];

% Offset the calculation to center the calculation space matrix
offset = size(calc)/2;

% Two index calculations for curve and straight lines
circleIndices = sub2ind(size(calc),ceil(p.Vertices(:,1) + offset(1)), ceil(p.Vertices(:,2)+ offset(1)+1));
straightIndicies = sub2ind(size(calc), round(patchX + offset(1)), round(patchY + offset(1)+1));

calcEdge = zeros(size(calc));

% Linear indicies of calculation space edges
edgeIndices = [transpose(circleIndices), straightIndicies];

% Matrix of just edge indices
calcEdge(edgeIndices) = 1;

% Rotate matrix values to align x axis
calcEdge = rot90(calcEdge);

% Convert linear indices to x,y positions of edge indices matrix
elemsMat = numel(calc);
[xc, yc] = ind2sub(size(calc),edgeIndices);
[xq, yq] = ind2sub(size(calc),1:elemsMat);

% Fills convex polygon and marks logical indices
% with contained cells
[in, on] = inpolygon(xq, yq, xc, yc);
calcSpace = zeros(size(calc));
calcSpace(in) = 1;
calcSpace(on) = 1;
calcSpace(edgeIndices) = 1;

% Logical matrix of available calculation space
% 1 is a possible location for a path otherwise avoid
calcSpace = rot90(calcSpace);
calcSpace = vision & calcSpace;

if Viz
    figure(1)
    pcolor(calcSpace)
    colormap([0 0 0; 1 1 1]);
    axis equal

    figure(2)
    pcolor(vision)
    colormap([0 0 0; 1 1 1]);
    axis equal

    figure(3)
    pcolor(calcEdge)
    colormap([0 0 0; 1 1 1]);
    axis equal

    figure(4)
    plot(p.Vertices(:,1),p.Vertices(:,2),'*k',patchXDown, patchYDown,'r*', patchXUp, patchYUp,'r*');
    axis equal
end
end

