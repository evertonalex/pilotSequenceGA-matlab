function phi = randomcandidate(phi)
%RANDOMCANDIDATE generates a random pilot sequence allocation hipermatrix
%   RANDOMCANDIDATE(phi) receives a null hipermatrix for pilot sequence allocation and generates a random hipermatrix.
%
%   See also FITNESS, PSO, GA.

    for ell=1:size(phi,3)
        q = randperm(size(phi,1));
        for i=1:size(phi,1)
            phi(i, q(i), ell) = 1;
        end
    end
    
end

