%% Plot Swath Profiles of Western Ghats
swathNos=[18, 39, 46, 49];
figure(1); t=tiledlayout(2,5); tlLoc=[1 3 6 8]; t.TileSpacing='loose';

txt={'a: Swath 18 (Northern Ghats)', 'b: Swath 39 (Central Ghats)',...
    'c: Swath 46 (Southern Ghats)','d: Swath 49 (Palghat Gap)'};

for k=1:length(swathNos)
    nexttile(tlLoc(k),[1 2])
    SwathProfilePlotterWG (swathNos(k), 'n','y','y')
    set(gca,'TickDir','out','FontSize',14,'XLim',[0 300],'XTick',0:50:300, ...
        'Box','off','Color',ones(1,3)*0.975)
    if k<3; xlabel(''); end ;  xline(300);  yline(24.2)

    yyaxis left; ylim([0 3]); yticks(0:1:3); ylabel('');
    text(2.96,2.824,txt{k},'FontSize',12,'BackgroundColor','w','EdgeColor','k')

    yyaxis right; ylim([0 24.2]); yticks(0:8:25); 
    if rem(k,2)~=0;ylabel(''); else; ylabel('Canopy Height (m)','FontSize',15); end
    
end

ylabel(t,'Elevation (km), Relief (km) & Rainfall (cm/day)','FontSize',15);

axes('Position',[0.64 0.194 0.1 0.24])
ROI_WG=shaperead('F:\Projects\1_Topo_Rain_Vege_Relation\2_AOI_Vector\AOI_Western_Ghat_WGS84.shp');
mapshow(ROI_WG,'FaceColor',ones(1,3)*0.975); hold on; 
[xTik,yTik] = LatLonTickCreation([72 80],[8 22],2,2);
xTik(2:2:end)=""; yTik(2:2:end)="";
for i=1:59
    ROI=shaperead(['F:\Projects\1_Topo_Rain_Vege_Relation\7_WG_Swath_Shapefile\Swath_',num2str(i),'.shp']);
    if isempty(intersect(i,swathNos))
        plot(ROI.X,ROI.Y,'Color',ones(1,3)*0.85);
    else
        plot(ROI.X,ROI.Y,'Color','k'); 
        text(ROI.BoundingBox(2,1)+0.05,ROI.BoundingBox(2,2)+0.1, ...
            ['\leftarrow #',num2str(i)],'FontSize',9,'Rotation',45)
    end
end
plot(ROI_WG.X,ROI_WG.Y,'Color','k','LineWidth',0.5);
set(gca,'FontSize',9,'TickDir','in','XLim',[72 80.5],'YLim',[8 20.5], ...
    'XTick',72:2:80,'YTick',8:2:22,'Box','off','XTickLabel',xTik, ...
    'YTickLabel',yTik,'XTickLabelRotation',0)
xline(80.5); yline(20.5); grid on

%% Plot Swath Profiles of Meghalaya Plateau
clear;clc;swathNos=[7 15 25 31];
figure(1); t=tiledlayout(2,3); tlLoc=[1 2 4 5]; t.TileSpacing='loose';

txt={'a: Swath 7 (Western Meghalaya)', 'b: Swath 15 (Central Meghalaya)',...
    'c: Swath 25 (Central Meghalaya)','d: Swath 31 (Eastern Meghalaya)'};

for k=1:length(swathNos)
    nexttile(tlLoc(k))
    SwathProfilePlotterMP (swathNos(k), 'n','y','y')
    set(gca,'TickDir','out','FontSize',14,'XLim',[0 150],'XTick',0:25:300, ...
        'Box','off','Color',ones(1,3)*0.975)
    if k<3; xlabel(''); end ;  xline(150);  yline(30)

    yyaxis left; ylim([0 4]); yticks(0:1:4); ylabel('');
    text(1.96,3.765,txt{k},'FontSize',12,'BackgroundColor','w','EdgeColor','k')

    yyaxis right; ylim([0 30]); yticks(0:6:30); 
    if rem(k,2)~=0;ylabel(''); else; ylabel('Canopy Height (m)','FontSize',15); end
    
end

ylabel(t,'Elevation (km), Relief (km) & Rainfall (cm/day)','FontSize',15);


axes('Position',[0.507 0.225 0.1 0.24])
ROI_MP=shaperead('F:\Projects\1_Topo_Rain_Vege_Relation\2_AOI_Vector\AOI_Meghalaya_Modified\AOI_Meghalaya.shp');
mapshow(ROI_MP,'FaceColor',ones(1,3)*0.975); hold on; 
[xTik,yTik] = LatLonTickCreation([90 94],[25 27],2,1); swathNos=[7 15 25 31];
for i=1:34
    ROI=shaperead(['F:\Projects\1_Topo_Rain_Vege_Relation\16_Meghalya_Peak_Rainfall_Analysis\NS_Swaths\NS_Swath_',num2str(i),'.shp']);
    if isempty(intersect(i,swathNos))
        plot(ROI.X,ROI.Y,'Color',ones(1,3)*0.85);
    else
        plot(ROI.X,ROI.Y,'Color','k'); 
        text(ROI.BoundingBox(1,1),ROI.BoundingBox(2,2)+0.1, ...
            ['\leftarrow #',num2str(i)],'FontSize',9,'Rotation',45)
    end
end
plot(ROI_MP.X,ROI_MP.Y,'Color','k','LineWidth',1);
set(gca,'FontSize',9,'TickDir','in','XLim',[89.7 93.6],'YLim',[24.75 26.31], ...
    'XTick',90:2:94,'YTick',25:26,'Box','off','XTickLabel',xTik, ...
    'YTickLabel',yTik,'XTickLabelRotation',0)
xline(93.6); yline(26.3); grid on

