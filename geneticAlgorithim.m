
function [individuals] = geneticAlgorithim(generationNumber, rateMutation,beta, sigma, populationSize, K, Tp, L, phi)
       
    bestSolution.fitness = 0;
    bestSolution.generation = 0;
    bestSolution.pilotSequenceOptimized = [];
    
    bestFitnessList = []; %graphic%

%     ############RUM GA############
    %inicializando population
    population = gaInitializeGeneration(populationSize, K, Tp, L, beta, sigma);
           
%     disp(population(1).population);
%     disp(population.fitness);      
       
       for gerNum=1:generationNumber
           newPopulation = [];
           
           disp("PROGRESS: " + (gerNum*100)/generationNumber + "% | geration: " + gerNum );
           
           sumEvaluations = 0;
           for s=1:populationSize
               sumEvaluations = sumEvaluations + population(s).fitness;
           end
%            disp("-sum evaluations: " + sumEvaluations);
           
           fitnessList = [];
           childensSwap = [];
                      
            for individualGenerated = 1:2:populationSize

                %-------------------------- ROLETA VICIADA --------------------------
%                 father1 = gaRouletteVitiate(population, sumEvalutions, gerNum);
%                 father2 = gaRouletteVitiate(population, sumEvalutions, gerNum);
                
                [father1, father2] = gaRouletteVitiated(population, sumEvaluations, gerNum);

%                 disp("father 1 -> " + father1 + " individual: " + individualGenerated);
%                 disp("father 2 -> " + father2 + " individual: " + individualGenerated);
                               
                 %-------------------------- CROSOVER--------------------------
                  individual1 = population(father1).hipermatrix;
                  individual2 = population(father2).hipermatrix;                  
%                   disp("individual1 - ");
%                   disp(individual1);
                  
                [children1, children2] = gaCrossover(individual1, individual2);
                 
                % individuos temporaria pós crossover
                childensSwap(individualGenerated).population = children1;     
                childensSwap(individualGenerated + 1).population = children2;
            end

            %-------------------------- MUTACAO --------------------------
            indivudualMutated = gaMutation(childensSwap, rateMutation);
            
%             RECALCULAR FITNESS (CORRIGIR)
            for r=1:length(indivudualMutated)
                temp = [];
                for p=1:length(indivudualMutated(r))
                    
%                     phi(p) = fitness(gerNum(:, :, :, p), beta, sigma);
%                     phi(p) = fitness(phiMutated(r).hiperMatrix(:, :, :, p), beta, sigma);

                    temp(p).hipermatrix = indivudualMutated(r).hiperMatrix;
                    temp(p).fitness = fitness(indivudualMutated(r).hiperMatrix(:, :, :, p), beta, sigma);
                    
%                     disp(temp(p).population);
%                     disp("temp FITNESS ---> " + temp(p).fitness);
                end
                
              fitnessList = [fitnessList, temp.fitness];
              newPopulation = [newPopulation;temp];
                              
            end
            
            %------------------------ MANTER MELHOR INDIVIDUO ------------------------
            if bestSolution.fitness <= max(fitnessList)
                index = 0;
                [bestSolution.fitness, index] = max(fitnessList);
                bestSolution.generation = gerNum;
                bestSolution.pilotSequenceOptimized = newPopulation(index).hipermatrix;
            else
                %reinserir o melhor individuo na população caso o mesmo não
                %sofra melhoras
                
                index = 0;
                worseIndividual.fitness = [];
                [worseIndividual.fitness, index] = min(fitnessList);
                
                %------prints para debug ---------
%                 disp("----SUB PIOR INDIVIDUO ----")
%                 
%                 disp("index ->" + index);
%                 disp("min substituir ---> " + worseIndividual.fitness);
%                 disp("por melhor fitness ---> " + bestSolution.fitness);
%                                
%                 disp("----SUB PIOR INDIVIDUO ----")
                %------prints para debug ---------
                
                newPopulation(index).fitness = bestSolution.fitness;
                newPopulation(index).hipermatrix = bestSolution.pilotSequenceOptimized;

            end
            
            %repopulando bestFitness list
            fitnessList = [];
            for pop=1:length(indivudualMutated)
               fitnessList = [fitnessList, newPopulation(pop).fitness]; 
%                disp("repopulando FITNESS 1 --> " + newPopulation(pop).fitness);
            end
            
            
            bestFitnessList = [bestFitnessList, max(fitnessList)];
%             disp("-max fitness: " + max(fitnessList));
            
            population = newPopulation;
            
%             disp(population(1).fitness);
%             disp(population(2).fitness);
%             disp(population(3).fitness);
%             disp(population(4).fitness);

       end
       
       disp("-------------- BEST OPTIMIZATION ---------------");
       disp("Fitness: " + bestSolution.fitness);
       disp("Generation: " +  bestSolution.generation);
       disp("PilotSequence HIPERMATRIX: ");
%        disp(bestSolution.pilotSequenceOptimized);
       disp("-------------- BEST OPTIMIZATION ---------------");
 
       figure(2);
       plot(bestFitnessList);
            
    individuals = bestSolution;
end