function p = drawuser(x,y)
%DRAWUSER Draws a square on user position.
%   DRAWUSER(x,y) draws a square on the (x,y) position and returns its properties.
%
%   See also PLOT.

hold on;
p = plot(x, y, 'MarkerFaceColor',[0 0 1],'MarkerSize',3,'Marker','diamond','LineWidth',2,'LineStyle','none','Color',[0 0 1]);

end

