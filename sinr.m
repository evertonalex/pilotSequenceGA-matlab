function [S,theta] = sinr(K,L,beta,h,sigma,W,P,phi)
%SINR Summary of this function goes here
%   Detailed explanation goes here

    [resW,resInter] = interference(K,L,beta,h,W);

    S = zeros(K,L);
    I = zeros(K,L);

    for k=1:K
        for ell=1:L
            for j=1:L
                I(k,ell) = I(k,ell) +  (P(:,j)'.*(phi(k,:,ell)*phi(:,:,j)'))*resInter(:,j,ell);
            end
            S(k,ell) = (P(k,ell)*resW(k,ell))/(I(k,ell)+sigma);
        end
    end
    
    theta = resW./(I+sigma);

end

