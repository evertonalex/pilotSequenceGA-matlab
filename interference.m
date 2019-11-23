function [resW,resInter] = interference(K,L,beta,h,W)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    resW = zeros(K,L);
    resInter = zeros(K,L,L);
    for k=1:K
        for ell=1:L
            for j=1:L
                if(ell == j) 
                    resW(k,ell) = beta(k,ell,ell)*abs((transpose(squeeze(h(k,ell,ell,:))))*squeeze(W(k,ell,ell,:)))^2;
                else
                    resInter(k,ell,j) = beta(k,ell,j)*abs((transpose(squeeze(h(k,ell,j,:))))*squeeze(W(k,ell,ell,:)))^2;
                end
            end
        end    
    end

end

