function SwathProfilePlotterWG (swathNo, slopeOn,reliefOn,imdRainOn)

load All_Wariable_Swath_Data_WesternGhats.mat VarData

elev=VarData.(['Swath_',num2str(swathNo)]).elev;
slope=VarData.(['Swath_',num2str(swathNo)]).slope;
rr=VarData.(['Swath_',num2str(swathNo)]).rr;
rain_imd=VarData.(['Swath_',num2str(swathNo)]).imd;
rain_trmm=VarData.(['Swath_',num2str(swathNo)]).trmm;
veg=VarData.(['Swath_',num2str(swathNo)]).ch;

% Finding the limits of the distances after comparing all the data sets
x_max=max([slope(end,5),elev(end,5),rain_imd(end,6),rain_trmm(end,6),rr(end,5),veg(end,5)]);
x_lim=[0 x_max];

% Settin the option for getting smooth curve
options = fitoptions('Method','Smooth','SmoothingParam',0.09);

addpath F:\Projects\Colorpmaps\
lnCols= mplHexCode({'black','royalblue','deepskyblue','orangered','lawngreen'});

yyaxis left

% Plotting the Elevation Data
elev(:,6)=0;
f1=fit(elev(:,5),elev(:,3)/1000,'smooth',options);
p=plot(f1,'-k',elev(:,5),elev(:,3)/1000,"or");
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(1);
hold on

% Plotting the IMD Rainfall Data
if string(imdRainOn)=="y"
rain_imd(:,7)=0;
f2=fit(rain_imd(:,6),rain_imd(:,3)/10,'smooth',options);
p=plot(f2,'-b',rain_imd(:,6),rain_imd(:,3)/10,'--w');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(2);
end

% Plotting the TRMM Rainfall Data
rain_trmm(:,7)=0;
f3=fit(rain_trmm(:,6),rain_trmm(:,3)/10,'smooth',options);
p=plot(f3,'-c',rain_trmm(:,6),rain_trmm(:,3)/10,'or');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(3);


% Plotting the Relative Relief Data
if string(reliefOn)=="y"
rr(:,6)=0;
f5=fit(rr(:,5),rr(:,3)/1000,'smooth',options);
p=plot(f5,'-r',rr(:,5),rr(:,3)/1000,'or');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(4);
end

% Setting the limits and label of left y-axis
y_max=max([max(rain_trmm(:,3)/10), max(rain_imd(:,3)/10), max(elev(:,3)/1000), max(rr(:,3)/1000)]);
ylim([0 y_max+0.5])
if string(reliefOn)=="y"
ylabel({['Elevation (km), Relief (km)'],['& Rainfall (cm/d)']},'FontSize',14);
else
    ylabel({['Elevation (km) & Rainfall (cm/d)']},'FontSize',12);
end
yyaxis right
% Plotting the Slope Data
if string(slopeOn)=="y"
slope(:,6)=0;
f4=fit(slope(:,5),slope(:,3),'smooth',options);
p=plot(f4,'-m',slope(:,5),slope(:,3),'or');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(4);
end

% Plotting the Tree Height Data
veg(:,6)=0;
f6=fit(veg(:,5),veg(:,3),'smooth',options);
p=plot(f6,'-g',veg(:,5),veg(:,3),'or');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(5);

% Setting the limits and lebel of right y-axis
ylim([0 max([max(slope(:,3)), max(veg(:,3))])])

if string(slopeOn)=="y"
    ylabel('Slope (deg) & Canopy Height (m)','FontSize',14);
else
    ylabel('Canopy Height (m)','FontSize',14);
end

% Setting up all other figure proprties
legend off
xlim(x_lim)
% Make both the axes color black
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';

xlabel('Distance from West to East (km)','FontSize',14);

end
