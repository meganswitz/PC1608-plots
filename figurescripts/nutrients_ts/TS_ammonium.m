% script creates TS diagram with points colored by ammonium concentration
%
% requires PC1608_data.mat
% requires PC1608_bottle_key.m
% requires colortoolbox.m
% requires GSW Oceanographic Toolbox
% requires SA_CT_plot.m
%
% See section at the bottom for saving options.
%
% Make sure to add path for all files necessary to run script. 

figure(1)
clf

% sample key loads data necessary for plotting
run PC1608_ctd_key;
run PC1608_bottle_key

% select attribute for plotting
attribute=NH4_b;

% key of cast numbers for each region
GBcasts=[34:43];
JBcasts=[19:24];
WBcasts=[5:7];
allothercasts=[1:4 8:18 25:33 44];

%pick cast numbers to plot (can use key above)
region=[1:44];

%linespecs
ms=200; % marker size
lw=1.3; % linewidth for bottle data
lwc=2.5; % linewidth for ctd data
falpha=.5; % alpha for markerface
lalpha=.7; % alpha for lines

%colors for this paper live in colortoolbox
run 'colortoolbox.m'

% uncomment to override default colors
% GB_l_color=twsky;
% JB_l_color=twyellow;
% WB_l_color=tworange;
% allother_l_color=tblack;

% GB_m_color=wsky;
% JB_m_color=wyellow;
% WB_m_color=worange;
% allother_m_color=black;

%bounds for CT diagram
SA_min=31.9;
SA_max=35.6;
CT_min=6;
CT_max=18.5;

% title necessary input for SA_CT_plot function
title=[];

contours= [23.5:.5:28];
p_ref= 0;

% calculate SA and CT for casts using GSW Oceanographic Toolbox
% p_c  is given in (psi), so divide by 1.45 to get pressure in (dbar)
% use SP1_c and t1_c as in-situ temperature and salinity measurements
[SA_c, in_ocean_c] = gsw_SA_from_SP(SP1_c,(p_c./1.45),long_c,lat_c);
CT_c = gsw_CT_from_t(SA_c,t1_c,(p_c./1.45));

% calculate SA and CT for bottle samples using GSW Oceanographic Toolbox
[SA_b, in_ocean_b] = gsw_SA_from_SP(SP_b,p_b,long_b,lat_b);
CT_b = gsw_CT_from_t(SA_b,t_b,p_b);

hold on
 
% draw the temperature-salinity box with density contours       
SA_CT_plot(p_ref,contours,title,SA_min,SA_max,CT_min,CT_max)

% scatter points for discrete bottle samples colored by nutrient concentration
scatter(SA_b,CT_b,ms,attribute,'filled','MarkerEdgeColor','none','MarkerFaceAlpha',falpha);
colormap(flipud(parula(4)));
h = colorbar;
caxis([0 1.08]);
h = colorbar;
h.Label.String = ['Ammonium (' char(181) 'M)'];
h.Direction = 'reverse';
h.Label.FontSize = 18;
h.FontSize = 14;
h.Ticks = [0, 0.27, 0.54, 0.81, 1.08];
h.YTickLabel={'0.00', '0.27', '0.54', '0.81', '1.08'};  

% % Uncomment this section if you want to save images locally.
% % set saveoption=0 for no save, 1 for scratchdir, 2 for finaldir
% saveoption=[0]
% try dpi=150 for fast write, dpi=500 for publish quality
% dpi=[0]
% %where to saveimages for saveoption==1
% scratchdir=['/path/'];
% %where to saveimages for saveoption==2
% finaldir=['/path/'];
% %savename
% savename='PC1608-TS-ammonium';
% %
% % specs for saving figure as image
% set(gcf,'PaperUnits','centimeters');
% set(gcf, 'PaperSize', [5 5]); 
% set(gcf, 'PaperPosition', [0 0 18 18]); 
% %
% % saving options, defined by directories and savenames defined above
% if saveoption==1
%     print('-dpng',['-r' num2str(dpi)],[scratchdir savename])
% elseif saveoption==2
%     prompt=['Are you sure you want to save ' savename ' in final directory? [Y/N] '];
%     xxx = input(prompt,'s');
%     if xxx=='Y'
%         print('-dpng',['-r' num2str(dpi)],[finaldir savename])
%         disp('Saved in final directory.')
%     else
%         disp('Nothing was saved.')
%     end
% end




