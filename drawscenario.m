function drawscenario(c,R,K,cx,cy,kx,ky)
%DRAWSCENARIO Creates a graphical representation of the telecommunications scenario.
%   DRAWSCENARIO(c,R,K,cx,cy,kx,ky) draws a scenario with hexagonal cells centered in the (cx,cy) arrays and users in the
%   array (kx,ky). Each cell has K users and largest width R. The hexagon cluster has size c.
%
%   See also HEXAGON, DRAWHEXAGON, DRAWUSER, PERMUTATIONS.

    idx = permutations(c);
    figure();
    for i=1:length(idx)
        if mod(idx(i,1),2) == 0
            cx(i) = idx(i,1) * (3 / 2) * R;
            cy(i) = idx(i,2) * sqrt(3) * R;
            [x, y] = hexagon(cx(i), cy(i), R);
            %Ploting Base Station
            b = plot(cx(i),cy(i),'MarkerFaceColor',[1 0 0],'MarkerSize',5,'Marker','o', ...
                'LineWidth',2,'LineStyle','none','Color',[1 0 0]);
            drawhexagon(x, y);
        else
            cx(i) = idx(i,1) * (3 / 2) * R;
            cy(i) = (idx(i,2) * sqrt(3)/2 * R) + sign(idx(i,2)) * (abs(idx(i,2)) - 1) * sqrt(3)/2 * R;
            [x, y] = hexagon(cx(i), cy(i), R);
            %Ploting Base Station
            b = plot(cx(i),cy(i),'MarkerFaceColor',[1 0 0],'MarkerSize',5,'Marker','o', ...
                'LineWidth',2,'LineStyle','none','Color',[1 0 0]);
            drawhexagon(x, y);
        end
        
        for k=1:K
            p = drawuser(kx(k,i), ky(k,i));
        end
        
    end
    xlabel('$x$-Position ($m$)');
    ylabel('$y$-Position ($m$)');
    title(['Mobile Terminals and Base Stations Position - $L =  ', num2str(chn(c)), '$.']);
    legend([b p],'Base Stations','Mobile Terminals');
    grid on;
    
        
end
