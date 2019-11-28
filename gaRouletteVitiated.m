function [father1, father2] = gaRouletteVitiated(population, sumEvatuions, popCurrent)
    father1 = 1;
    father2 = 1;
        
    popSize = length(population);
    randomSort = sumEvatuions*rand(1, 'double');
        
%     disp("sumEvalution " + sumEvatuions);
%     disp("randomSORTEIO 1 - " + randomSort);
%     
    sumLoopsRouletteFather1 = 0;
    i = 1;
    while i < popSize && sumLoopsRouletteFather1 < randomSort
        sumLoopsRouletteFather1 =  sumLoopsRouletteFather1 + population(i).fitness;
        father1 = father1 + 1;
        i = i + 1;
    end
    
    randomSort = sumEvatuions*rand(1, 'double');
%     disp("randomSORTEIO 2 - " + randomSort);
    sumLoopsRouletteFather2 = 0;
    j = 1;
    while j < popSize && sumLoopsRouletteFather2 < randomSort
        if father1 ~= (father2 + 1)
            sumLoopsRouletteFather2 =  sumLoopsRouletteFather2 + population(j).fitness;
            father2 = father2 + 1;            
        end
        j = j + 1;
    end
end