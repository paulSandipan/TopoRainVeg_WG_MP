
function SwathProfilePlotterMP (swathNo, slopeOn,reliefOn,imdRainOn)

load All_Wariable_Swath_Data_Meghalaya.mat VarData

elv=VarData.(['Swath_',num2str(swathNo)]).elev;
slope=VarData.(['Swath_',num2str(swathNo)]).slope;
rr=VarData.(['Swath_',num2str(swathNo)]).rr;
rain_imd=VarData.(['Swath_',num2str(swathNo)]).imd;
rain=VarData.(['Swath_',num2str(swathNo)]).trmm;
veg=VarData.(['Swath_',num2str(swathNo)]).ch;
dist=VarData.(['Swath_',num2str(swathNo)]).dist;

% Settin the option for getting smooth curve
options = fitoptions('Method','Smooth','SmoothingParam',0.09);

addpath F:\Projects\Colorpmaps\
lnCols= mplHexCode({'black','royalblue','deepskyblue','orangered','lawngreen'});

yyaxis left

% Plotting the Elevation Data
f1=fit(elv(:,5),elv(:,3)/1000,'smooth',options);
p=plot(f1,'-k',elv(:,5),elv(:,3)/1000,"or");
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(1);
hold on


% Plotting the IMD Rainfall Data
if string(imdRainOn)=="y"
f2=fit(rain_imd(:,6),rain_imd(:,3)/10,'smooth',options);
p=plot(f2,'-b',rain_imd(:,6),rain_imd(:,3)/10,'--w');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(2);
end

% Plotting the TRMM Rainfall Data
f3=fit(rain(:,6),rain(:,3)/10,'smooth',options);
p=plot(f3,'-c',rain(:,6),rain(:,3)/10,'or');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(3);


% Plotting the Relative Relief Data
if string(reliefOn)=="y"
f5=fit(dist,rr(:,1)/1000,'smooth',options);
p=plot(f5,'-r',dist,rr(:,1)/1000,'or');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(4);
end


% Setting the limits and label of left y-axis
ylim([0 4]);     yticks(0:4)
if string(reliefOn)=="y"
ylabel({['Elevation (km), Relief (km)'],['& Rainfall (cm/d)']},'FontSize',14);
else
    ylabel({['Elevation (km) & Rainfall (cm/d)']},'FontSize',12);
end

yyaxis right

% Plotting the Tree Height Data
f6=fit(dist,veg(:,1),'smooth',options);
p=plot(f6,'-g',dist,veg(:,1),'or');
p(1).Color='none'; p(2).LineWidth=1; p(2).Color=lnCols(5);

% Setting the limits and lebel of right y-axis
    ylim([0 25]);     yticks(0:5:25)

if string(slopeOn)=="y"
    ylabel('Slope (deg) & Canopy Height (m)','FontSize',14);
else
    ylabel('Canopy Height (m)','FontSize',14);
end

% Setting up all other figure proprties
    legend off
    x_lim=[0 150];
    xticks(0:25:150)
    xlim(x_lim)
    grid off

    xline(150,'k')
    
    % Make both the axes color black
    ax = gca;
    ax.YAxis(1).Color = 'k';
    ax.YAxis(2).Color = 'k';

xlabel('Distance from South to North (km)','FontSize',14);

end






