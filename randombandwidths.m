function [r] = randombandwidths(W,Bmax)
%RANDOMBANDWITHS Generate a random array of bandwidths.
%   RANDOMBANDWITHS(W,Bmax) generates a random array of W bandwidths from 1Mhz to Bmax Hz.
%
%   See also CREATESCENARIO.

    p = linspace(1E6, Bmax, ((Bmax - 1E6) / 1E6) + 1);
    r = p(randperm(length(p),W));

end

