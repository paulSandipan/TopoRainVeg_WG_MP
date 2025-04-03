%% Loading the required datasets
clear;clc

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
wg_aoi=shaperead('F:\Projects\1_Topo_Rain_Vege_Relation\2_AOI_Vector\AOI_Western_Ghat_WGS84.shp');

% Elev=ncread('WG_AOI_DEM.nc','elevation');
% xElev=ncread('WG_AOI_DEM.nc','lon');
% yElev=ncread('WG_AOI_DEM.nc','lat');

slope=ncread('WG_AOI_Slope.nc','slope');
slope(slope<0)=NaN;
xSlope=ncread('WG_AOI_Slope.nc','lon');
ySlope=ncread('WG_AOI_Slope.nc','lat');

relief=ncread('WG_AOI_Relief.nc','relief');
relief=relief/1000;
relief(relief<0)=NaN;
xRelief=ncread('WG_AOI_Relief.nc','lon');
yRelief=ncread('WG_AOI_Relief.nc','lat');

CH=double(ncread('WG_AOI_Canopy_Height.nc','canopy_height'));
xCH=ncread('WG_AOI_Canopy_Height.nc','lon');
yCH=ncread('WG_AOI_Canopy_Height.nc','lat');
% [intrpX,interpY]=meshgrid(xSlope,ySlope);
% [orgX,orgY]=meshgrid(xCH,yCH);
% interpCH=interp2(orgX,orgY,CH',intrpX,interpY,"linear");
CH(CH<=0)=NaN;
CH(CH>30)=NaN;


cd F:\Projects\1_Topo_Rain_Vege_Relation\3_Rainfall_2000_20\Finalised_Mat_files\IMD_Processed_Data\
load("Avg_mon.mat")
load('lat.mat')
load("lon.mat")
IMD=Avg_mon;
xIMD=lon;
yIMD=lat;
cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
IMD=FindMatrixDataInAOI(xIMD,yIMD,wg_aoi.X,wg_aoi.Y,IMD);

cd F:\Projects\1_Topo_Rain_Vege_Relation\3_Rainfall_2000_20\Finalised_Mat_files\TRMM_Processed_Data\
load("AOI_Avg_mon.mat")
load("AOI_lat.mat")
load('AOI_lon.mat')
TRMM=AOI_Avg_mon;
xTRMM=AOI_lon;
yTRMM=AOI_lat;
cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
TRMM=FindMatrixDataInAOI(xTRMM,yTRMM,wg_aoi.X,wg_aoi.Y,TRMM);

%% Plotting
cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS(xSlope,ySlope,slope,'Purples',[0 20])

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS(xRelief,yRelief,relief,'YlOrBr',[0 0.5])

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS(xTRMM,yTRMM,TRMM,'Blues',[0 10])

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS(xCH,yCH,CH,'Greens',[0 30])

%%
[prctile(slope,99,"all") prctile(slope,5,"all")]
[prctile(relief,95,"all") prctile(relief,5,"all")]
[prctile(TRMM,99,"all") prctile(TRMM,5,"all")]
%%
t=tiledlayout(2,4);
cLim=[0 20;0 0.5;0 1.0;0 30];
cDiff=[4,0.1,0.2,5];
cMap={'Purples','YlOrBr','Blues','Greens'};
txt={'Slope (^o)','Relief (km)','Rainfall (cm d^-^1)','Canopy Height (m)'};

for i=1:4
    ax= nexttile(i);
    set(gca,'FontSize',14)
    cd E:\MATLAB_Colormaps\ColorBrewer2\cbrewer2\
    colormap(ax,cbrewer2(cMap{i}))

    cTiks=cLim(i,1):cDiff(i):cLim(i,2);
    cLab=string(cTiks);
    if i~=4
        cLab(end)=strcat("> ",cLab(end));
    end

    clim([cLim(i,:)])
    cb=colorbar;
    cb.Ticks=cTiks;
    cb.TickLabels=cLab;
    cb.FontSize=14;
    cb.Label.String=txt{i};
    cb.TickLength=0.015;
    cb.TickDirection="out";
    cb.Location="east";


end

t.TileSpacing='compact'; 


























