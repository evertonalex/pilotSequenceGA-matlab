function [beta,shadowing] = pathloss(d,d0,f,gamma,s)
%PATHLOSS Calculate the shadowing and path loss components.
%   PATHLOSS(d,d0,F,gamma,S) calculate the path loss for the array/matrix/hipermatrix d, where d is the distance, d0 the
%   reference distance (1m for indoor and 10m for outdoor), f is the transmission frequency, gamma the path loss exponent
%   (usually [2,8]) and s the shadowing variance in dB.
%
%   See also CALCDISTANCE.
    
    beta = zeros(size(d,1), size(d,2), size(d,3));
    shadowing = normrnd(0, sqrt(s), size(d,1), size(d,2), size(d,3));
    for i=1:size(d,1)
        for j=1:size(d,2)
            for r=1:size(d,3)
                shadowing(i, j, r) = 10^(shadowing(i, j, r) / 10);
                beta(i, j, r) = ((3E8 / (4 * pi * f * d0))^2) * ((d0 / d(i, j, r))^gamma) * shadowing(i, j, r);
            end
        end
    end
    
end

