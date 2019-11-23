function [father] = gaRouletteVitiate(population, sumEvatuions, popCurrent)
    father = 0;
    popSize = length(population);
    randomSort = sumEvatuions.*rand(1, 'double');
%     disp("sumEvalution " + sumEvatuions);
%     disp("randomSORTEIO - " + randomSort);
    
    sumLoopsRoulette = 0;
    
    i = 1;
    while i < popSize && sumLoopsRoulette < randomSort
        sumLoopsRoulette =  sumLoopsRoulette + population(i).fitness;
        father = father + 1;
        i = i + 1;
    end
end