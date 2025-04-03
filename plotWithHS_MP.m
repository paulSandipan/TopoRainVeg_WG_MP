function plt = plotWithHS_MP(x,y,data,clMp,cLim)

mp_aoi=shaperead('F:\Projects\1_Topo_Rain_Vege_Relation\2_AOI_Vector\AOI_Meghalaya_Modified\AOI_Meghalaya.shp');


% Calculate Hillshade
cd F:\Projects\1_Topo_Rain_Vege_Relation\AOI_Mapping\
elev=ncread('MP_BoundBoxMask_DEM.nc','Megh_ElevBath.tif');
elevX=ncread('MP_BoundBoxMask_DEM.nc','lon');
elevY=ncread('MP_BoundBoxMask_DEM.nc','lat');
cd F:\Projects\1_Topo_Rain_Vege_Relation\Codes\
h=hillshade(elev,elevX,elevY);

plt =figure;

ax1=axes;
axesm('miller');
m=pcolor(ax1,elevX,elevY,h');
m.EdgeAlpha=0;
set(gca,'Color','w')
% cm=MPL_gist_gray;
cd F:\Projects\1_Topo_Rain_Vege_Relation\Codes\
colormap(ax1,MPL_gist_gray_V2)
hold on
plot(mp_aoi.X,mp_aoi.Y,'k','LineWidth',1)

view(2)
ax2=axes;
axesm('miller');
cd E:\MATLAB_Colormaps\ColorBrewer2\cbrewer2\
colormap(ax2,(cbrewer2(clMp)))
m2=pcolor(x,y,data');
m2.EdgeAlpha=0;
clim(cLim)
hold on
plot(ax2,mp_aoi.X,mp_aoi.Y,'k','LineWidth',1)

% cb=colorbar(ax2,"eastoutside");
% cb.FontSize=14;

%Link axes
linkaxes([ax1,ax2])
%Hide the top axes
ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];

ax1.XTick='';
ax1.YTick='';
ax1.YLim=[24.4563 26.5687];
ax1.XLim=[89.5396 93.7854];
ax1.TickDir="out";
ax1.Box='on';
end
