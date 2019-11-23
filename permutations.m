function [p] = permutations(c)
%PERMUTATIONS List of all possible indexes.
%   PERMUTATIONS(c) returns an array with all possible permutations of hexagons positions in order to draw a centered hexagon
%   cluster.
%
%   See Also DRAWHEXAGON, HEXAGON, CHN.
    [x,y] = meshgrid(-c+1:c-1,-c+1:c-1);
    x = x(:);
    y = y(:);
    i = 1;
    while i <= length(x)

        if y(i) == 0 && mod(x(i),2) ~= 0
            
            y(i) = [];
            x(i) = [];
            i = i - 1;

        end
        
        if mod(x(i),2) ~= 0 && abs(x(i)) + abs(y(i)) > c+1
            
            y(i) = [];
            x(i) = [];
            i = i - 1;
            
        end
        
        if abs(x(i)) + abs(y(i)) > c && mod(abs(x(i)),2) == 0
           
            y(i) = [];
            x(i) = [];
            i = i - 1;
            
        end
        
        i = i + 1;


    end
    
    p = [x, y];

    
end

