function [outs] = isinhexagon(x,y,cx,cy,R)
%ISINHEXAGON Verifies if a (x,y) point in inside hexagon.
%   ISINHEXAGON(x,y,cx,cy,R) verifies if the (x,y) point is inside the (cx,cy) centered hexagon with largest width R.
%
%   See also GENPOSITIONS.
    
    dx = abs(x - cx);
    dy = abs(y - cy);
    if dx > R || dy > R * sqrt(3)/2
        outs = false;
    elseif - sqrt(3)/2 * dx + R * sqrt(3)/2 - dy < 0
        outs = false;
    else
        outs = true;
    end
    
end
