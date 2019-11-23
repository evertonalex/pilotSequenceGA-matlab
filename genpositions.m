function [rx, ry] = genpositions(R)
%GENPOSITIONS Generate a matrix of x and y positions possibles inside an hexagon.
%   GENPOSITIONS(R) generates a meshgrid of possibilities inside a hexagon of largest width R
%
%   See also ISINHEXAGON.
    
    x = linspace(-R, R, 2 * R + 1);
    y = linspace(ceil(-R * sqrt(3)/2), floor(R * sqrt(3)/2), floor(R * sqrt(3)/2) ...
        - ceil(-R * sqrt(3)/2) + 1);
    [xg, yg] = meshgrid(x, y);
    rx = zeros(size(xg,1),size(xg,2));
    ry = zeros(size(yg,1),size(yg,2));
    for i=1:length(y)
        for j=1:length(x)
            try
                if (xg(i,j) ~= 0 || yg(i,j) ~= 0) && isinhexagon(xg(i,j), yg(i,j), 0, 0, R)
                    rx(i,j) = xg(i, j);
                    ry(i,j) = yg(i, j);
                end
            catch
                disp('Problema com o indexador do array: OutofBounds');
            end
        end
    end

end

