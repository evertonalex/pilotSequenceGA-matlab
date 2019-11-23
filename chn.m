function [c] = chn(n)
%CHN Returns the centered hexagon number for order n.
%   CHN(n) returns 1 + (6 * (0.5 * n * (n - 1)))
%
%   See also HEXAGON, DRAWHEXAGON.

c = 1 + (6 * (0.5 * n * (n - 1)));

end

