function [pgbest, gbest] = pso(beta,sigma,psize,maxit)
%PSO Particle swarm optimization implementation.
%   PSO(beta,sigma,psize,maxit) returns the best pilot sequence allocation for scenario with beta channel gains and sigma
%   noise power. The psize and maxit represents the population size for pso and the maximum number of iterations.
%
%   See also FITNESS, RANDOMCANDIDATE.

    pop = zeros(size(beta,1),size(beta,1),size(beta,3),psize);
    v = pop;
    f = zeros(psize,1);
    for p=1:psize
        pop(:, :, :, p) = randomcandidate(pop(:, :, :, p));
        f(p) = fitness(pop(:, :, :, p), beta, sigma);
    end
    % Individual Best Fitness Values
    lbest = f;
    % Individual Bests
    plbest = pop;
    % Global Best Fitness Values
    gbest = zeros(maxit+1, 1);
    [gbest(1), idxbest] = max(f);
    % Global Best
    pgbest = pop(:, :, :, idxbest);

    for i=2:maxit+1
        disp(i);
        for p=1:psize

            % Calculating particle velocity
            v(:, :, :, p) = v(:, :, :, p) + unifrnd(0, 1) * (pop(:, :, :, p) - plbest(:, :, :, p)) ...
                            + unifrnd(0, 1) * (pop(:, :, :, p) - pgbest);

            % Calculating the probability of binary change according to velocity for each dimension in a single particle
            cprob = 1./(1 + exp(-v(:, :, :, p)));

            for d1=1:size(v,1)
                for d2=1:size(v,2)
                    for d3=1:size(v,3)
                        % Tmp is a random value between 0 and 1
                        tmp = unifrnd(0,1);
                        % Test for changing
                        if tmp < cprob(d1, d2, d3)
                            pop(d1, d2, d3, p) = 1;
                        else
                            pop(d1, d2, d3, p) = 0;
                        end
                    end
                end
            end

            % Discarding unfeasible candidates
            if sum(sum(sum(pop(:, :, :, p)))) > size(pop,1)*size(pop,3)
                pop(:, :, :, p) = zeros(size(pop,1),size(pop,2),size(pop,3));
                pop(:, :, :, p) = randomcandidate(pop(:, :, :, p));
            end

            % Recalculate the Fitness
            f(p) = fitness(pop(:, :, :, p), beta, sigma);
            % Update Individual Bests
            if f(p) > lbest(p)
                lbest(p) = f(p);
                plbest(:, :, :, p) = pop(:, :, :, p);
            end
            
        end
        
        % Update Global Best
        [tgbest, idxbest] = max(f);
        if tgbest > gbest(i-1)
            gbest(i) = tgbest;
            pgbest = pop(:, :, :, idxbest);
        else
            gbest(i) = gbest(i-1);
        end
        
        disp(i)
        
    end

end

