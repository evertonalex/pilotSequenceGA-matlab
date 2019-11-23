function res = fitness(phi,beta,sigma)
%FITNESS Calculate the objective function value.
%   FITNESS(phi,beta,sigma) calculates the sum of signal to interference plus noise ratio of the pilot sequence allocation
%   hipermatrix phi taking into account beta channel gain coefficients and sigma power noise.
%
%   See also PSO, GA.

    f = zeros(size(phi,1), size(phi,3));
    for ell=1:size(phi,3)
        for k=1:size(phi,1)
            f(k, ell) = beta(k, ell, ell);
            deno = 0;
            for j=1:size(phi,3)
                for kline=1:size(phi,1)
                    if j ~= ell
                        deno = deno + (phi(k, :, ell) * phi(kline, :, j)')*beta(kline, j, ell);
                    end
                end
            end
            deno = deno + sigma;
            f(k, ell) = f(k, ell) / deno;
        end
    end
    
    res = sum(f(:));

end
