function [classMid,stats] = phaseSpaceTrajectory(x,y,div)
clear xx yy class classMid stats
xx=x; yy=y;
class=0:div:max(xx);
for k=1:length(class)-1
idx=find(xx>=class(k) & xx<class(k+1));
stats(k,1)=median(yy(idx),'omitnan');
stats(k,2)=prctile(yy(idx),75);
stats(k,3)=prctile(yy(idx),25);
end
for k=1:length(class)-1
classMid(k)=(class(k)+class(k+1))/2;
end

end