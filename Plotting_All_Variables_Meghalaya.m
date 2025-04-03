%% Loading the required datasets
clear

mp_aoi=shaperead('F:\Projects\1_Topo_Rain_Vege_Relation\2_AOI_Vector\AOI_Meghalaya_Modified\AOI_Meghalaya.shp');

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\

slope=ncread('MP_AOI_Slope2.nc','slope');
slope(slope<0)=NaN;
xSlope=ncread('MP_AOI_Slope2.nc','lon');
ySlope=ncread('MP_AOI_Slope2.nc','lat');

relief=ncread('MP_AOI_Relief1.nc','relief');
relief=relief/1000;
relief(relief<0)=NaN;
xRelief=ncread('MP_AOI_Relief1.nc','lon');
yRelief=ncread('MP_AOI_Relief1.nc','lat');

CH=double(ncread('MP_AOI_Canopy_Height.nc','canopy_height'));
xCH=ncread('MP_AOI_Canopy_Height.nc','lon');
yCH=ncread('MP_AOI_Canopy_Height.nc','lat');
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
IMD=FindMatrixDataInAOI(xIMD,yIMD,mp_aoi.X,mp_aoi.Y,IMD);

cd F:\Projects\1_Topo_Rain_Vege_Relation\3_Rainfall_2000_20\Finalised_Mat_files\TRMM_Processed_Data\
load("Megh_AOI_Avg_mon.mat")
load("Megh_AOI_lat.mat")
load('Megh_AOI_lon.mat')
TRMM=AOI_Avg_mon;
xTRMM=AOI_lon;
yTRMM=AOI_lat;
cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
TRMM=FindMatrixDataInAOI(xTRMM,yTRMM,mp_aoi.X,mp_aoi.Y,TRMM);

%% Plotting
cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS_MP(xSlope,ySlope,slope,'Purples',[0 25])

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS_MP(xRelief,yRelief,relief,'YlOrBr',[0 0.8])

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS_MP(xTRMM,yTRMM,TRMM,'Blues',[0 20])

cd F:\Projects\1_Topo_Rain_Vege_Relation\Variables_in_netcdf_format\
plotWithHS_MP(xCH,yCH,CH,'Greens',[0 30])

%%
[prctile(slope,99,"all") prctile(slope,5,"all")]
[prctile(relief,95,"all") prctile(relief,5,"all")]
[prctile(TRMM,99,"all") prctile(TRMM,5,"all")]
%%
t=tiledlayout(2,4);
cLim=[0 25;0 0.8;0 20;0 30];
cDiff=[5,0.2,4,5];
cMap={'Purples','YlOrBr','Blues','Greens'};
txt={'Slope (^o)','Relief (km)','Rainfall (mm d^-^1)','Canopy Height (m)'};

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
    cb.Location="southoutside";


end




























