function [initialPopulation] = gaInitializeGeneration(populationSize, K, Tp, L, beta, sigma)

%     ******TESTE*****
%     C = 2;
% %     Base Stations (1 per cell)
%     L = chn(C);
%     populationSize = 6;
%     K = 10;
%     Tp = K;
%     beta = 20;
%     ******TESTE*****
    
    phi = zeros(populationSize,1);
%     phi = randomcandidate(phi);
    
    population = [];
    
%     for i=1:populationSize
%         disp("i-> " + i)
%         
%         for j=1:K
%            phi = zeros(length(beta), length(beta), length(beta), populationSize);
% %            population(i) = phi;
%             population =[population, phi];
%         end
%         
%     end
    
    pop = zeros(size(beta,1),size(beta,1),size(beta,3),populationSize);
    for p=1:populationSize
        pop(:, :, :, p) = randomcandidate(pop(:, :, :, p));
        phi(p) = fitness(pop(:, :, :, p), beta, sigma);
        
        population(p).population = [];
               
        population(p).population = [population(p).population, pop];
        population(p).fitness = phi(p);
    end
    
    initialPopulation = population;
end

