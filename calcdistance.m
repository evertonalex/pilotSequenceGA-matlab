function [d] = calcdistance(kx,ky,cx,cy)
%CALCDISTANCE Calculate distances.
%   CALCDISTANCE(kx,ky,cx,cy) calculates all the distance between all users in all cells with respect to each cell base
%   station position.
%
%   See also RANDOMPOSITION, DRAWHEXAGON.

    d = zeros(size(kx,1), size(kx,2), size(cx,1));
    for i=1:size(kx,1)
        for j=1:size(kx,2)
            for r=1:size(cx,1)
                d(i, j, r) = sqrt((kx(i, j) - cx(r))^2 + (ky(i, j) - cy(r))^2);
            end
        end
    end

end

