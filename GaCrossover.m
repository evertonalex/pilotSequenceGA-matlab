function [children1, children2] = GaCrossover(individual, otherIndividual)
    children1 = [];
    children2 = [];
 
    children1(:,:,1:3) = individual(:,:,1:3);
    children1(:,:,4:7) = otherIndividual(:,:,4:7);
    
    children2(:,:,1:3) = otherIndividual(:,:,1:3);
    children2(:,:,4:7) = individual(:,:,4:7);     
end