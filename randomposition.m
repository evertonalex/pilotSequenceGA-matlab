function [tempx,tempy] = randomposition(xg,yg,kx,ky)
%RANDOMPOSITION Generates a random user position.
%   RANDOMPOSITION(xg,yg,kx,ky) generate a random user positon from list (xg,yg) that is not already on the list of sorted
%   user positions (kx,ky).
%
%   See also GENPOSITIONS.

    i = -1;
    j = -1;
    while i < 0 || j < 0
        try
            i = randi([1 length(xg)]);
            j = randi([1 length(yg)]);
            tempx = xg(i,j);
            tempy = yg(i,j);
            if tempx == 0 && tempy == 0
                i = -1;
            elseif (sum(sum(ismember(kx,tempx).*(ismember(ky,tempy)))) >= 1)
                i = -1;
            end
        catch
            i = -1;
        end
    end

end

