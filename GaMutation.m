
function [individualMutated] = GaMutation(individual, rateMutation)

    celula = 1;
    
    mut = reshape(randperm(10),2,[]);
    
%     disp(mut)

    for p=1:length(individual)
        pilotSequence = individual(p).population;
        
        randonSequence = randi([0,1],1,1);
 
        if(randonSequence < rateMutation)
%             disp("VOU MUTAR")

            temp = pilotSequence(mut(1,2), :, celula);
            pilotSequence(mut(1,2),:,celula) = pilotSequence(mut(1,1),:,celula);
            pilotSequence(mut(1,1), :, celula) = temp;
        end
        
        individualMutated(p).hiperMatrix = pilotSequence;
    end
    
%     phiMutated = phiMut;
end