function [cgain] = genfading(K,L,M)
%GENFADING Generates fading coeficients for each user-cell/antenna combination.
%   Recieves the number of users, cells and antennas and generates Flat Rayleigh fading coefficients.

cgain = (1/sqrt(2))*(normrnd(0,1,[K,L,L,M])+1i*normrnd(0,1,[K,L,L,M]));

end

