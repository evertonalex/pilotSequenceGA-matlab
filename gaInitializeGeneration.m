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
    
    population = [];
       
    pop = zeros(size(beta,1),size(beta,1),size(beta,3),populationSize);
    for p=1:populationSize
        pop(:, :, :, p) = randomcandidate(pop(:, :, :, p));
        phi(p) = fitness(pop(:, :, :, p), beta, sigma);
        
        population(p).hipermatrix = [];
               
        population(p).hipermatrix = [population(p).hipermatrix, pop];
        population(p).fitness = phi(p);
    end
    
    initialPopulation = population;
end

