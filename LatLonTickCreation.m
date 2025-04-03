
function [xTik,yTik] = LatLonTickCreation(xLim,yLim,xDiff,yDiff)

xVal=xLim(1):xDiff:xLim(2);
for i=1:length(xVal)
    xTik(i)=strcat(num2str(xVal(i)),"^oE");
end

yVal=yLim(1):yDiff:yLim(2);
for i=1:length(yVal)
    yTik(i)=strcat(num2str(yVal(i)),"^oN");
end

end

