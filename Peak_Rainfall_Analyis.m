%% Scatter Plot: Topography-Rainfall-Canopy height at peak rainfall locations
clear; clc;
path='H:\My Drive\1_Topography_Rainfall_Canpy_Height_Relation\First_Revision_PCE\Revision_Codes\';
dataWG=readtable([path,'Peak_Data.xlsx']);
dataMP=readtable([path 'Peak_Elevation_Info.xlsx']);

data=NaN(max([height(dataWG),height(dataMP)]),5,2);
data(:,:,1)=[dataWG.elev/1000 dataWG.rain dataWG.RR/1000 dataWG.MEAN_CanopyHeight dataWG.Slope];
data(1:height(dataMP),:,2)=[dataMP.MEAN_Elev/1000 dataMP.rain dataMP.RR/1000 dataMP.MEAN_CanopyHeight dataMP.MEAN_Slope];

varName={'Elevation (km)','Rainfall (cm/day)','Relief (km)', 'Canopy Height (m)'};
varCode={'EV','RF','RR','CH'};  figIdx=1;
figNum={'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(h)','(i)','(j)','(k)'};
varMin=[0 0 0 0; 0 4 0 10];
varMax=[1.2 15 2   25; 1.6 20 1.5 23];
varDiff=[0.3 3 0.4 5; 0.4 4 0.3 3];

idx=[1 2 3; 3 2 2; 1 4 2; 2 4 3; 3 4 1];
tlLoc=[1 2; 4 5; 1 2; 4 5; 1 2];
addpath 'F:\Projects\Colorpmaps\NCL_Colormaps\'; cMap=MPL_Spectral; 
figure(1); t1=tiledlayout(2,3); 
figure(2); t2=tiledlayout(2,3);
figure(3); t3=tiledlayout(2,3); 
sz=70; mec='#252525'; trans=0.5; ls='--'; lw=2; lc='k';

for i=1:length(idx)
    if i<=2; figure(1); elseif i>2 && i<=4; figure(2); else; figure(3); end
    for j=1:2
    ax=nexttile(tlLoc(i,j));
    x=data(:,idx(i,1),j); y=data(:,idx(i,2),j); z=data(:,end,j);%z=data(:,idx(i,3),j); 
    ind=find(isnan(x)==1); x(ind)=[]; y(ind)=[]; z(ind)=[];
    scatter(x,y,sz,z,"filled",'MarkerEdgeColor',mec,'MarkerFaceAlpha',trans,'LineWidth',0.5)

    ols=fitlm(x,y); cc=ols.Coefficients.Estimate;
    xHat=linspace(prctile(x,1),prctile(x,99),100);
    yHat=cc(1)+cc(2)*xHat;
    hold on; plot(xHat,yHat,'LineStyle',ls,'LineWidth',lw,'Color',lc)

    xLim=[varMin(j,idx(i,1)) varMax(j,idx(i,1))];
    yLim=[varMin(j,idx(i,2)) varMax(j,idx(i,2))]; if i<=2 && j==2; yLim=[4 24];end
    xDiff=varDiff(j,idx(i,1)); yDiff= varDiff(j,idx(i,2));
    set(gca,'FontSize',14,'TickDir','out','XLim',xLim,'YLim',yLim, ...
        'XTick',xLim(1):xDiff:xLim(2),'YTick',yLim(1):yDiff:yLim(2),'Color',ones(1,3)*0.975)
    xline(xLim(2)); yline(yLim(2))
   
    cc=round(cc,2); [r,p,ru,rl]=corrcoef(x,y,'Rows','complete');
    r=round(r(1,2),2); ru=round(ru(1,2),2); rl=round(rl(1,2),2);
    xVar=varCode{idx(i,1)}; yVar=varCode{idx(i,2)};
    xloc=xLim(1)+0.2*xDiff; yloc=yLim(2)-0.3*yDiff;
    txt=['$','r_p=',num2str(r),'\: (CI=[',num2str(ru),',',num2str(rl),']) $'];
    text(xloc,yloc,txt,'FontSize',14,'Interpreter','latex')
    yloc=yLim(2)-0.8*yDiff;
    txt=['$',yVar,'=',num2str(cc(1)),'+',num2str(cc(2)) ,'\times ',xVar,'$'];
    text(xloc,yloc,txt,'FontSize',14,'Interpreter','latex')

    yloc=yLim(2)-0.1*yDiff; xloc=xLim(1)-1*xDiff; 
    text(xloc,yloc,figNum{figIdx},'FontSize',16,'Interpreter','tex')
    figIdx=figIdx+1;

    % if idx(i,3)==1; path='F:\Projects\Colorpmaps\NCL_Colormaps\'; 
    % else; path='F:\Projects\Colorpmaps\ColorBrewer_v2\cbrewer2\'; end
    % addpath(path)
    % if idx(i,3)==1; cMap=MPL_terrain; elseif idx(i,3)==2; cMap=cbrewer2('Blues');
    % elseif idx(i,3)==3; cMap=cbrewer2('Reds'); else; cMap=cbrewer2('Greens'); end
    colormap(ax,cMap);   
    %cLim=[min(varMin(:,idx(i,3))) max(varMax(:,idx(i,3)))]; cDiff=varDiff(j,idx(i,3));
    cLim=[0 25]; clim(cLim);
    cb=colorbar; cb.TickDirection='out'; %cb.Label.String=varName{idx(i,3)};
    cb.FontSize=14; cb.Label.String='Slope (^o)';
    xlabel(varName{idx(i,1)}); ylabel(varName{idx(i,2)})
    if i==1; if j==1; title('Western Ghats'); else; title('Meghalaya Plateau'); end;  end
    end
end

%% Western Ghats: Mapping the Eleveation, Rainfall, Relief and Canopy Height at Peak Rainfall Location
clear; clc;
path='H:\My Drive\1_Topography_Rainfall_Canpy_Height_Relation\First_Revision_PCE\Revision_Codes\';
dataWG=readtable([path,'Peak_Data.xlsx']);
data=[dataWG.rain dataWG.elev/1000 dataWG.RR/1000 dataWG.MEAN_CanopyHeight];

varName={'Rainfall (cm/day)','Elevation (km)','Relief (km)', 'Canopy Height (m)'};
figNum={'(a)','(b)','(c)','(d)'};
varMin=[2 0.2 0 0]; varMax=[12 1 1.6 25]; varDiff=[2 0.2 0.4 5];
figure(1);t=tiledlayout(1,4); %t.Padding='compact'; t.TileSpacing='compact';
sz=50; mec='#252525'; trans=0.8; 

for k=1:4
    ax=nexttile; hold on; axesm miller; WG_ROI_Plotting;
    x=dataWG.x; y=dataWG.y; z=data(:,k);
    scatter(x,y,sz,z,"filled",'MarkerEdgeColor',mec,'MarkerFaceAlpha',trans,'LineWidth',0.5)
    set(gca,'FontSize',14,'TickDir','in','XLim',[72 80],'YLim',[7.5 22.5], ...
        'XTick',72:2:80,'YTick',8:2:22,'Box','off','CLim',[varMin(k) varMax(k)], ...
        'XColor','none','YColor','none')
    %xline(80); yline(22.5); grid on; 
    if k>1; yticklabels('');end
    if k==1 || k==4; path='F:\Projects\Colorpmaps\ColorBrewer_v2\cbrewer2\';  
    else; path='F:\Projects\Colorpmaps\NCL_Colormaps\'; end
    addpath(path)
    if k==2 ; cMap=MPL_terrain; elseif k==1; cMap=cbrewer2('RdYlBu');
    elseif k==3; cMap=flip(cmocean_thermal);  else; cMap=cbrewer2('YlGn'); end
    colormap(ax,cMap(10:end-10,:))%cbrewer2('Oranges'); 

    cb=colorbar; cbProp=get(cb); cbDim=cbProp.Position; dx=0.065; dy=0.25;
    set(cb,'Position',[cbDim(1)-dx cbDim(2)+dy cbDim(3) cbDim(4)*0.6])% To change size
    cb.FontSize=14;
    cb.Label.String=varName{k}; cb.Ticks=varMin(k):varDiff(k):varMax(k);

    text(71.5,22,figNum{k},'FontSize',16,'Interpreter','tex')

end


function WG_ROI_Plotting
ROI_WG=shaperead('F:\Projects\1_Topo_Rain_Vege_Relation\2_AOI_Vector\AOI_Western_Ghat_WGS84.shp');
mapshow(ROI_WG,'FaceColor',ones(1,3)*0.975); hold on
for i=1:59
    ROI=shaperead(['F:\Projects\1_Topo_Rain_Vege_Relation\7_WG_Swath_Shapefile\Swath_',num2str(i),'.shp']);
    plot(ROI.X,ROI.Y,'Color',ones(1,3)*0.85); hold on
end 
plot(ROI_WG.X,ROI_WG.Y,'Color','k','LineWidth',1);
% lb=shaperead('E:\Topo_Rain_Vege_Relation\AOI_Mapping\Land_Bound.shp');
% for i=1:length(lb)
%     plot(lb(i).X,lb(i).Y,'Color','k','LineWidth',1);
% end
end


clear; clc;
path='H:\My Drive\1_Topography_Rainfall_Canpy_Height_Relation\First_Revision_PCE\Revision_Codes\';
data=readtable([path,'Peak_Data.xlsx']); 
load([path, 'Peak_Rainfall_q.mat'])
load([path, 'RR_Data_NS.mat'])

% Calculating distance along the orogen
x=data.x(1,1); y=data.y(1,1); n=length(data.x); dist1(1,1)=0;
for kk=2:n
    b(kk-1,1)=(data.x(kk,1)-data.x(kk-1,1))*110;
    h(kk-1)=(data.y(kk,1)-data.y(kk-1,1))*110;
    dist1(kk,1)=sqrt((b(kk-1)^2)+(h(kk-1)^2));
end
dis=cumsum(dist1);

figure(2);t=tiledlayout(3,5); t.Padding="compact"; t.TileSpacing="tight";

% Plotting 1: Moisture Plot
options = fitoptions('Method','Smooth','SmoothingParam',0.09);
x1=final_data(1:58,2); x2=final_data(1:58,3); x1(isnan(x1)==1)=0; x2(isnan(x2)==1)=0;
plotData=[outData(:,6) x1 x2];
yLim=[0.04 0.16; 0 400; 0 400]; yDiff=[0.04 100 100];
lnCols= mplHexCode({'lightseagreen','lightslategray','darkkhaki','darkviolet'});
nexttile(1,[1,3]);hold on
for i=1:3
    if i==1; yyaxis left; else; yyaxis right; end
    f=fit(dis,plotData(:,i),'smooth',options);
    p=plot(f,'-b',dis,plotData(:,i),'or');
    p(1).Color='none'; p(2).LineWidth=1.5; p(2).Color=lnCols(i);

    set(gca,'FontSize',12,'TickDir','out','YColor','k', ...
        'XLim',[0 max(dis)],'XTick',0:100:max(dis),'YLim',yLim(i,:), ...
        'YTick',yLim(i,1):yDiff(i):yLim(i,2))
    ytickangle(-90); ytickangle(90);xtickangle(90)
    xlabel(''); xticklabels('')
    if i==1;ylabel({['Vertically Integrated'],['Specific Humidity (kg/kg)']}); end
    if i==3;ylabel({['Elevation (m) &'], ['Distance from coast (km)']}); end
end
legend off; yline(yLim(i,2))

%Vertically Integrated Specific Humidity
%leftarrow Elevation (m) at which Relief reaches 200m
%Distance from the coast at which relief reaches 200m

% Ploting: Peak Location Variables
nexttile(6,[1 3]); yyaxis left; hold on;
plotData=[data.elev/1000 data.rain/10, data.RR/1000 data.MEAN_CanopyHeight];
lnCols= mplHexCode({'black','royalblue','indianred','yellowgreen'});
yLim=[0 2.2; 0 24]; yDiff=[0.5 6];
for i=1:4
    if i<=3; yyaxis left; else; yyaxis right; end
    f=fit(dis,plotData(:,i),'smooth',options);
    p=plot(f,'-b',dis,plotData(:,i),'or');
    p(1).Color='none'; p(2).LineWidth=1.5; p(2).Color=lnCols(i);
    set(gca,'FontSize',12,'TickDir','out','YColor','k', ...
    'XLim',[0 max(dis)],'XTick',0:100:max(dis))
    if i<=3; ylim(yLim(1,:)); yticks(yLim(1,1):yDiff(1):yLim(1,2)); 
    else; ylim(yLim(2,:)); yticks(yLim(2,1):yDiff(2):yLim(2,2)); end
    if i==3; ylabel({['Elevation(km), Relief (km)'] ['&  Rainfall (cm d^-^1)']}); end
    if i==4; ylabel('Canopy Height (m)'); end
    if i==4; xlabel('N-S Distance along the Orogen (km)'); else; xlabel(''); end
    ytickangle(-90); ytickangle(90); xtickangle(90); 
end
legend off; yline(yLim(2,2));

%% Meghalaya: Mapping the Eleveation, Rainfall, Relief and Canopy Height at Peak Rainfall Location
clear; clc; clf
path='H:\My Drive\1_Topography_Rainfall_Canpy_Height_Relation\First_Revision_PCE\Revision_Codes\';
dataMP=readtable([path,'Peak_Elevation_Info.xlsx']);
data=[dataMP.rain/10 dataMP.MEAN_Elev/1000 dataMP.RR/1000 dataMP.MEAN_CanopyHeight];

varName={'Rainfall (cm/day)','Elevation (km)','Relief (km)', 'Canopy Height (m)'};
figNum={'(a)','(b)','(c)','(d)'};
varMin=[0.6 0.2 0.2 0]; varMax=[1.8 1.4 1.4 25]; varDiff=[0.3 0.3 0.3 5];
figure(1);t=tiledlayout(2,3); t.Padding='compact'; t.TileSpacing='compact';
sz=50; mec='#252525'; trans=0.8; 

for k=1:4
    ax=nexttile; hold on; axesm miller; MP_ROI_Plotting;
    x=dataMP.x; y=dataMP.y; z=data(:,k);
    scatter(x,y,sz,z,"filled",'MarkerEdgeColor',mec,'MarkerFaceAlpha',trans,'LineWidth',0.5)
    set(gca,'FontSize',14,'TickDir','in','XLim',[89.8 93.5],'YLim',[24.7 26.3], ...
        'Box','off','CLim',[varMin(k) varMax(k)], ...
        'XColor','none','YColor','none')
    if k==1 || k==4; path='F:\Projects\Colorpmaps\ColorBrewer_v2\cbrewer2\';  
    else; path='F:\Projects\Colorpmaps\NCL_Colormaps\'; end
    addpath(path)
    if k==2 ; cMap=MPL_terrain; elseif k==1; cMap=cbrewer2('RdYlBu');
    elseif k==3; cMap=flip(cmocean_thermal);  else; cMap=cbrewer2('YlGn'); end
    colormap(ax,cMap(10:end-10,:))%cbrewer2('Oranges'); 

    cb=colorbar; cb.FontSize=14; cb.Location='southoutside';
    cb.Label.String=varName{k}; cb.Ticks=varMin(k):varDiff(k):varMax(k);
    cbProp=get(cb); cbDim=cbProp.Position; dx=0.031; dy=0.25;
    set(cb,'Position',[cbDim(1)+dx cbDim(2) cbDim(3)*0.7 cbDim(4)])% To change size

    text(90.05,25.8,figNum{k},'FontSize',16,'Interpreter','tex')

end

function MP_ROI_Plotting
ROI_MP=shaperead('F:\Projects\1_Topo_Rain_Vege_Relation\2_AOI_Vector\AOI_Meghalaya_Modified\AOI_Meghalaya.shp');
mapshow(ROI_MP,'FaceColor',ones(1,3)*0.975); hold on
for i=1:34
    ROI=shaperead(['F:\Projects\1_Topo_Rain_Vege_Relation\16_Meghalya_Peak_Rainfall_Analysis\NS_Swaths\NS_Swath_',num2str(i),'.shp']);
    plot(ROI.X,ROI.Y,'Color',ones(1,3)*0.85); hold on
end 
plot(ROI_MP.X,ROI_MP.Y,'Color','k','LineWidth',1);
end

% Calculating distance along the orogen
x=dataMP.x(1,1); y=dataMP.y(1,1); n=length(dataMP.x); dist1(1,1)=0;
for kk=2:n
    b(kk-1,1)=(dataMP.x(kk,1)-dataMP.x(kk-1,1))*110;
    h(kk-1)=(dataMP.y(kk,1)-dataMP.y(kk-1,1))*110;
    dist1(kk,1)=sqrt((b(kk-1)^2)+(h(kk-1)^2));
end
dis=cumsum(dist1);

% Ploting: Peak Location Variables
data=[dataMP.rain/20 dataMP.MEAN_Elev/1000 dataMP.RR/1000 dataMP.MEAN_CanopyHeight];
options = fitoptions('Method','Smooth','SmoothingParam',0.09);

figure(2);t=tiledlayout(2,5); t.Padding='compact'; t.TileSpacing='compact';
nexttile(1,[1 3]);hold on; yLim=[0 2.2; 0 24]; yDiff=[0.5 6];
lnCols= mplHexCode({'royalblue','black','indianred','yellowgreen'});

for i=1:4
    if i<=3; yyaxis left; else; yyaxis right; end
    f=fit(dis,data(:,i),'smooth',options);
    p=plot(f,'-b',dis,data(:,i),'or');
    p(1).Color='none'; p(2).LineWidth=1.5; p(2).Color=lnCols(i);
    set(gca,'FontSize',12,'TickDir','out','YColor','k', ...
    'XLim',[0 max(dis)],'XTick',0:50:max(dis))
    if i<=3; ylim(yLim(1,:)); yticks(yLim(1,1):yDiff(1):yLim(1,2)); 
    else; ylim(yLim(2,:)); yticks(yLim(2,1):yDiff(2):yLim(2,2)); end
    if i==3; ylabel({['Elevation(km), Relief (km)'] ['&  Rainfall (cm d^-^1)']}); end
    if i==4; ylabel('Canopy Height (m)'); end
    if i==4; xlabel('W-E Distance along the Orogen (km)'); else; xlabel(''); end
end
legend off; yline(yLim(2,2));
pbaspect([0.8 0.2 1])
