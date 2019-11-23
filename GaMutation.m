
function [phiMutated] = GaMutation(phi, rateMutation)

    celula = 1;
    
    mut = reshape(randperm(10),2,[]);
    
%     disp(mut)

    for p=1:length(phi)
        phiMut = phi(p).population;
        
        randonSequence = randi([0,1],1,1);
 
        if(randonSequence < rateMutation)
%             disp("VOU MUTAR")

            temp = phiMut(mut(1,2), :, celula);
            phiMut(mut(1,2),:,celula) = phiMut(mut(1,1),:,celula);
            phiMut(mut(1,1), :, celula) = temp;
        end
        
        phiMutated(p).hiperMatrix = phiMut;
    end
    
%     phiMutated = phiMut;
end