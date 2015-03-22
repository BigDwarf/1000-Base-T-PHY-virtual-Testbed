a2 = gca;
xLimits = get(a2,'XLim');
yLimits = get(a2,'YLim');
axis([ xLimits(1)*2 xLimits(2)*2 yLimits(1) yLimits(2)]);