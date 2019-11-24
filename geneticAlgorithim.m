
function [individuals] = geneticAlgorithim(generationNumber, rateMutation,beta, sigma, populationSize, K, Tp, L, phi)
   
    phiAllZeros = zeros(K,Tp,L);
    fitnessNote = 0;
    chromosome = [];
    geracao = 0;
    
    
    population = [];
    bestSolution = 0;
    bestFitnessList = []; %graphic%


%     ############RUM GA############
    %inicializando population
    population = gaInitializeGeneration(populationSize, K, Tp, L, beta, sigma);
       
%     disp(population(1).population);
%     disp(population.fitness);

       
       newPopulation = [];
       for gerNum=1:generationNumber
           
           sumEvalutions = 0;
           for s=1:populationSize
               sumEvalutions = sumEvalutions + population(s).fitness;
           end
           disp("SUM EVALUTIONS: " + sumEvalutions);
           
           fitnessList = [];
           childensSwap = [];
                      
            for individualGenerated = 1:2:populationSize

                %-------------------------- ROLETA VICIADA --------------------------
%                 father1 = gaRouletteVitiate(population, sumEvalutions, gerNum);
%                 father2 = gaRouletteVitiate(population, sumEvalutions, gerNum);
                
                [father1, father2] = gaRouletteVitiated(population, sumEvalutions, gerNum);

                disp("father 1 -> " + father1 + " individual: " + individualGenerated);
                disp("father 2 -> " + father2 + " individual: " + individualGenerated);
                               
                 %-------------------------- CROSOVER--------------------------
                  individual1 = population(father1).population;
                  individual2 = population(father2).population;                  
%                   disp("individual1 - ");
%                   disp(individual1);
                  
                [children1, children2] = GaCrossover(individual1, individual2);
                 
                % individuos temporaria pós crossover
                childensSwap(individualGenerated).population = children1;     
                childensSwap(individualGenerated + 1).population = children2;
            end

            %-------------------------- MUTACAO --------------------------
            indivudualMutated = GaMutation(childensSwap, rateMutation);
            
%             RECALCULAR FITNESS (CORRIGIR)
            for r=1:length(indivudualMutated)
                temp = [];
                for p=1:length(indivudualMutated(r))
                    
                    
%                     phi(p) = fitness(gerNum(:, :, :, p), beta, sigma);
                    
%                     phi(p) = fitness(phiMutated(r).hiperMatrix(:, :, :, p), beta, sigma);

                    temp(p).population = indivudualMutated(r).hiperMatrix;
                    temp(p).fitness = fitness(indivudualMutated(r).hiperMatrix(:, :, :, p), beta, sigma);
                    
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
       
       disp("bestFitness");
       disp(bestFitnessList);
 
       figure(2);
       plot(bestFitnessList);
            
    individuals = 'ga';
end