% script creates figure with temperature-salinity diagram for all casts
%
% requires PC1608_data.mat
% requires PC1608_ctd_key.m
% requires colortoolbox.m
% requires GSW Oceanographic Toolbox
% requires SA_CT_plot.m
%
% NOTE: CTD data for station 11 is not included in this plot as there is an incomplete record of temperature and salinity.
% NOTE: CTD data for station 37 salinity above 66 meters appears to be compromised and is not included in this plot. 
%
% See section at the bottom for saving options.
%
% Make sure to add path for all files necessary to run script. 

figure(1)
clf

% sample key loads data necessary for plotting
run PC1608_ctd_key;

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

% key of cast numbers for each region
GBcasts=[34:43];
JBcasts=[19:24];
WBcasts=[5:7];
allothercasts=[1:4 8:18 25:33 44];

%pick cast numbers to plot (can use key above)
region=[1:44];

% calculate SA and CT for casts using GSW Oceanographic Toolbox
% p_c  is given in (psi), so divide by 1.45 to get pressure in (dbar)
% use SP1_c and t1_c as in-situ temperature and salinity measurements
[SA_c, in_ocean_c] = gsw_SA_from_SP(SP1_c,(p_c./1.45),long_c,lat_c);
CT_c = gsw_CT_from_t(SA_c,t1_c,(p_c./1.45));


hold on

% draw the temperature-salinity box with density contours    
SA_CT_plot(p_ref,contours,title,SA_min,SA_max,CT_min,CT_max)

% Begin plotting lines for each cast.      
for k=region
    
	rows=find(sta_c(:,1)==k); 
    
	if ismember(k,GBcasts)==1      
		if ismember(k,37)==1 % Remove compromised data from plot by only plotting below 66 meters.
			rows2=find(depth_c(rows)>=66); 
			GBplot=plot(SA_c(rows(rows2)),CT_c(rows(rows2)),'LineStyle','-','Color',GB_l_color,'Linewidth',lwc);
		else
			GBplot=plot(SA_c(rows),CT_c(rows),'LineStyle','-','Color',GB_l_color,'Linewidth',lwc);
		end
            
	elseif ismember(k,JBcasts)==1
		JBplot=plot(SA_c(rows),CT_c(rows),'LineStyle','-','Color',JB_l_color,'Linewidth',lwc);
	elseif ismember(k,WBcasts)==1
		WBplot=plot(SA_c(rows),CT_c(rows),'LineStyle','-','Color',WB_l_color,'Linewidth',lwc);
	elseif ismember(k,allothercasts)==1 
		if ismember(k,11)==1
			% Incomplete data for station 11, reason unknown. Do not include in plot. 
		else
			allotherplot=plot(SA_c(rows),CT_c(rows),'LineStyle','-','Color',allother_l_color,'Linewidth',lwc);
		end
	end
end
   
% legend labels
label_GB='Georges Basin region';
label_JB='Jordan Basin region';
label_WB='Wilkinson Basin region';
label_allelse='All other stations';

% create legend
[legh,objh,plots,text]=legend([GBplot, JBplot, WBplot, allotherplot],label_GB, label_JB, label_WB, label_allother);
% legend('boxoff')

% adjust legend symbol appearance
lineh = findobj(objh,'type','line');
set(lineh,'Linewidth',5);

% adjust legend text fontsize
texth = findobj(objh,'type','text');
set(texth,'Fontsize',14);

% set x position, y position, width, and height of legend box 
% disable warning message
wtmp = warning('off', 'MATLAB:handle_graphics:exceptions:SceneNode');
legh.Position(1)=.48;
legh.Position(2)=.70;
legh.Position(3)=.4;
legh.Position(4)=.16;


% % Uncomment this section if you want to save images locally.
% % set saveoption=0 for no save, 1 for scratchdir, 2 for finaldir
% saveoption=[0];
% % try dpi=150 for fast write, dpi=500 for publish quality
% dpi=[150];
% %where to saveimages for saveoption==1
% scratchdir=['path/'];
% %where to saveimages for saveoption==2
% finaldir=['/path/'];
% %savename
% savename='PC1608-TS-allstations';
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
