
function [individuals] = geneticAlgorithim(generationNumber, rateMutation,beta, sigma, populationSize, K, Tp, L, phi)
   

%     phiAllZeros é a hipermatriz populada com zeros
    phiAllZeros = zeros(K,Tp,L);
    fitnessNote = 0;
    chromosome = [];
    geracao = 0;
    
    
    population = [];
    bestSolution = 0;
    bestFitnessList = []; %graphic%


%     ############RUM GA############
    %primeiraGeracao
    disp("vou chamar firstGeneration");
    
    [g1] = firstGeneration(phiAllZeros);
    function firstGeneration = firstGeneration(phiAllZeros)
        disp("RUN FIRST GENERATION");
%         disp(phiAllZeros);
        
%         disp("allZeros")
%         disp(length(phiAllZeros))

        for ell=1:length(phiAllZeros)
%             q = list(range(0, len(phi[0])))
%               q = list(range(0, len(phi[0])))
%             np.random.shuffle(q)
%             phi[range(0, len(phi[0])), q, ell] = 1
%         return phi
        end
        firstGeneration = phiAllZeros;
    end
%     disp(g1)

    %inicializando population
    population = gaInitializeGeneration(populationSize, K, Tp, L, beta, sigma);
        
%     disp(population(1).population);
%     disp(population.fitness);

       sumEvalutions = 0;
       for s=1:populationSize
           sumEvalutions = sumEvalutions + population(s).fitness;
       end

%        disp("SUM EVALUTIONS");
%        disp(sumEvalutions);
       


       
       newPopulation = [];
       for gerNum=1:generationNumber
           
           fitnessList = [];
           popSwap = [];
                      
            for individualGenerated = 1:2:populationSize

                %-------------------------- ROLETA VICIADA --------------------------
                father1 = gaRouletteVitiate(population, sumEvalutions, gerNum);
                father2 = gaRouletteVitiate(population, sumEvalutions, gerNum);
%                 disp("father 1 -> " + father1);
%                 disp("father 2 -> " + father2);
                               
                 %-------------------------- CROSOVER--------------------------
                  individual1 = population(father1).population;
                  individual2 = population(father2).population;                  
%                   disp("individual1 - ");
%                   disp(individual1);
                  
                [children1, children2] = GaCrossover(individual1, individual2);

                 
                % populacao temporaria pós crossover
                popSwap(individualGenerated).population = children1;     
                popSwap(individualGenerated + 1).population = children2;
            end

            %-------------------------- MUTACAO --------------------------
            phiMutated = GaMutation(popSwap, rateMutation);
            
%             RECALCULAR FITNESS (CORRIGIR)
            for r=1:length(phiMutated)
                temp = [];
                for p=1:length(phiMutated(r))
                    
                    
%                     phi(p) = fitness(gerNum(:, :, :, p), beta, sigma);
                    
%                     phi(p) = fitness(phiMutated(r).hiperMatrix(:, :, :, p), beta, sigma);

                    temp(p).population = phiMutated(r).hiperMatrix;
                    temp(p).fitness = fitness(phiMutated(r).hiperMatrix(:, :, :, p), beta, sigma);
                    
%                     disp(temp(p).population);
                    disp("temp FITNESS ---> " + temp(p).fitness);
                end
                
              fitnessList = [fitnessList, temp.fitness];
  
              newPopulation = [newPopulation;temp];
                              
            end
           
            
            bestFitnessList = [bestFitnessList, max(fitnessList)];
            
            disp("MAX FITNESS -> " + max(fitnessList));
            
            
            population = [];
            population = newPopulation;
            
%             disp(population(1).fitness);
%             disp(population(2).fitness);
%             disp(population(3).fitness);
%             disp(population(4).fitness);

            disp("progress: " + (gerNum*100)/generationNumber + "% | geration: " + gerNum );
       end
       
%        disp("bestFitness");
%        disp(bestFitnessList);
 
       figure(2);
       plot(bestFitnessList);
            
    individuals = 'ga';
end