function [kx,ky,cx,cy,d,shadowing,beta,h] = createscenario(C,R,K,Channels,Fmin,Fmax,M,S,gamma,d0)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    L = chn(C);
    idx = permutations(C);
    [xg, yg] = genpositions(R);

    kx = zeros(K,L);
    ky = zeros(K,L);
    cx = zeros(L,1);
    cy = zeros(L,1);
    beta = zeros(K,L,L,Channels);
    shadowing = zeros(K,L,L,Channels);
    h = zeros(K,L,L,M,Channels);

    % Random Frequencies  
    if(Fmin + Fmax == 0)
        F = 2.4E9;
    else
        F = randsample(Fmin:1E5:Fmax,Channels);
    end
    
    % Random User Positions
    for i=1:length(idx)
        if mod(idx(i,1),2) == 0
            cx(i) = idx(i,1) * (3 / 2) * R;
            cy(i) = idx(i,2) * sqrt(3) * R;
        else
            cx(i) = idx(i,1) * (3 / 2) * R;
            cy(i) = (idx(i,2) * sqrt(3)/2 * R) + sign(idx(i,2)) * (abs(idx(i,2)) - 1) * sqrt(3)/2 * R;
        end
        for k=1:K
            [kx(k, i), ky(k, i)] = randomposition(xg, yg, kx, ky);
            [kx(k, i), ky(k, i)] = transferposition(kx(k, i), ky(k, i), cx(i), cy(i));
        end
    end


    % Calculating Distances
    d = calcdistance(kx, ky, cx, cy);

    % Calculating Path Loss and Shadowing
    for i=1:Channels
        [beta(:, :, :, i), shadowing(:, :, :, i)] = pathloss(d, d0, F(i), gamma, S);
    end

    % Calculating Fading
    for i=1:Channels
        h(:, :, :, :, i) = genfading(K,L,M);
    end
    

end

