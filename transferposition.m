function [nx,ny] = transferposition(x,y,cx,cy)
%TRANSFERPOSITION Deslocates points.
%   TRANSFERPOSITION(x,y,cx,cy) deslocates point (x,y) from origin related to (cx,cy) related.
%
%   See also HEXAGON.

    nx = x + cx;
    ny = y + cy;

end

