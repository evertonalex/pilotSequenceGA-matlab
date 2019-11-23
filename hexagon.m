function [x,y] = hexagon(cx,cy,R)
% HEXAGON Defines the edges of a hexagon.
%   [x, y] = HEXAGON(cx,cy,R) create the edges to draw an hexagon with the largest width R centered in (cx,cy)
%
%   See also POLYGON.

x = R*[-1 -0.5 0.5 1 0.5 -0.5 -1]+cx;
y = R*sqrt(3)*[0 -0.5 -0.5 0 0.5 0.5 0]+cy;

end

