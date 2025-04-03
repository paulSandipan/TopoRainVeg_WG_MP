%% Data Loading and Processing
clear; clc; clf

data=readtable("H:\My Drive\1_Topography_Rainfall_Canpy_Height_Relation\First_Revision_PCE\" + ...
    "Github_Code_Data\TRMM_Grid_System_All_Variables_WesternGhats.xlsx");
ind=find(data.CanopyHeight==0); data(ind,:)=[];
vec = [data.CanopyHeight data.Mean_Elev/1000 data.Relief/1000 data.Avg_Rainfall/10];
vec(:,:,2)=NaN;

data=readtable(['H:\My Drive\1_Topography_Rainfall_Canpy_Height_Relation\First_Revision_PCE\' ...
    'Github_Code_Data\TRMM_Grid_System_All_Variables_Meghalaya.xlsx']);
ind=find(data.CanopyHeight==0); data(ind,:)=[];
idx=find(data.TRMM_X==0);       data(idx,:)=[];
ind1=find(isnan(data.TRMM_Rain)==1);
ind2=find(isnan(data.MEAN_Elev)==1);
ind3=find(isnan(data.MEAN_Slope)==1);
ind4=find(isnan(data.RR)==1);
ind=[ind1 ind2 ind3 ind4];
data(ind,:)=[];
vec(1:height(data),:,2)=[data.CanopyHeight data.MEAN_Elev/1000 data.RR/1000 data.TRMM_Rain/10];
clearvars -except vec

%% Plotting
xLimMin=[0 0 0; 0 0 0]; xLimMax=[2.5 2 2; 2 1.4 2];
xDiff=[0.5 0.4 0.4; 0.4 0.3 0.4]; yLim=[0 30; 0 25]; yDiff=[5 5];
sz=15; trans=0.6; div=[0.025 0.05 0.05]; figIdx=1; yLoc=[0.4 0.35];
xVarName={'Elevation (km)','Relief (km)','Rainfall (cm/day)'};
figNum={'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(h)','(i)','(j)','(k)'};
t=tiledlayout(2,3);

for i=1:2
    for j=1:3
        nexttile
        y=vec(:,1,i); x=vec(:,j+1,i); 
        idx=find(isnan(x) | isnan(y)); x(idx)=[]; y(idx)=[];
        scatter(x,y,15,'filled','MarkerEdgeColor','#d9d9d9', ...
            'MarkerFaceAlpha',trans,'MarkerFaceColor','#d9d9d9','Marker','+')
        hold on;
        [classMid,stats] = phaseSpaceTrajectory(x,y,div(j));
        scatter(classMid,stats(:,1),sz*3,'MarkerEdgeColor','k')
        set(gca,'FontSize',14,'TickDir','out','XLim', ...
            [xLimMin(i,j) xLimMax(i,j)],'YLim',yLim(i,:), ...
            'XTick',xLimMin(i,j):xDiff(i,j):xLimMax(i,j),'YTick', ...
            yLim(i,1):yDiff(i):yLim(i,2))
        xline([xLimMin(i,j) xLimMax(i,j)]); yline(yLim(i,:))
        xlabel(xVarName{j}); ylabel('Canopy Height (m)')
        if i==1; txt=strcat(figNum{figIdx},' Western Ghats'); 
        else; txt=strcat(figNum{figIdx},' Meghalaya Plateau'); end
        text(xLimMin(i,j)+xDiff(i,j)*0.1,yLim(i,2)-yDiff(i)*yLoc(i), ...
            txt,'FontSize',14); figIdx=figIdx+1;
        
    end
end
%ylabel(t,'Western Ghats   Meghalaya Plateu','FontSize',16,'FontWeight','bold')

