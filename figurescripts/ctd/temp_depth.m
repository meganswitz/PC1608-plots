% script creates figure with temperature and depth for all casts
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

% calculate SA and CT for casts using GSW Oceanographic Toolbox
% p_c  is given in (psi), so divide by 1.45 to get pressure in (dbar)
% use SP1_c and t1_c as in-situ salinity measurements
[SA_c, in_ocean_c] = gsw_SA_from_SP(SP1_c,(p_c./1.45),long_c,lat_c);
CT_c = gsw_CT_from_t(SA_c,t1_c,(p_c./1.45));

%pick attribute to plot
attribute=CT_c;

%linespecs
ms=85; % marker size
lw=2; % linewidth for bottle data
lwc=2; % linewidth for ctd data
alpha=.7; % alpha for markerface
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

% key of cast numbers for each region
GBcasts=[34:43];
JBcasts=[19:24];
WBcasts=[5:7];
allothercasts=[1:4 8:18 25:33 44];

%pick cast numbers to plot (can use key above)
region=[1:44];

hold on

% limits and labels for a and y axes
xlim([5.5 18.5]);
ylim([0 370]);
xlabel('\fontsize{24}Temperature (\circC)');
ylabel('\fontsize{24}Depth (m)');
savename='PC1608-temperature-depth';

for k=region
    
    rows=find(sta_c==k);   
    
    if ismember(k,GBcasts)==1
        if ismember(k,37)==1 % Remove compromised data from plot by only plotting below 66 meters.
            rows2=find(depth_c(rows)>=66); 
            GBplot=plot(attribute(rows(rows2)),depth_c(rows(rows2)),'LineStyle','-','Color',GB_l_color,'Linewidth',lwc);
        else
            GBplot=plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',GB_l_color,'Linewidth',lwc);
        end
    elseif ismember(k,JBcasts)==1
        JBplot=plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',JB_l_color,'Linewidth',lwc);
    elseif ismember(k,WBcasts)==1
        WBplot=plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',WB_l_color,'Linewidth',lwc);
    elseif ismember(k,allothercasts)==1 % Incomplete data for station 11, reason unknown. Do not include in plot. 
        if ismember(k,11)==1
            % Incomplete data for station 11, reason unknown. Do not include in plot. 
        else
            allotherplot=plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',allother_l_color,'Linewidth',lwc);
        end       
    end
end

% specs for axes
set(gca,'Ydir','reverse')
set(gca,'XAxisLocation','top');

% fonts for axes labels
xAX = get(gca,'XAxis');
set(xAX,'FontSize', 14)
yAX = get(gca,'YAxis');
set(yAX,'FontSize', 14)

% labels for legend
label_GB='Georges Basin region';
label_JB='Jordan Basin region';
label_WB='Wilkinson Basin region';
label_allother='All other stations';

% create legend
[legh,objh,plots,text]=legend([GBplot, JBplot, WBplot, allotherplot],label_GB, label_JB, label_WB, label_allother);
legend('boxoff')

% adjust legend symbol appearance
lineh = findobj(objh,'type','line');
set(lineh,'Linewidth',5);

% set x position, y position, width, and height of legend box 
% disable warning message
wtmp = warning('off', 'MATLAB:handle_graphics:exceptions:SceneNode');
legh.Position(1)=.52;
legh.Position(2)=.13;
legh.Position(3)=.26;
legh.Position(4)=.16;

% adjust legend text fontsize
texth = findobj(objh,'type','text');
set(texth,'Fontsize',14);


% % Uncomment this section if you want to save images locally.
% % set saveoption=0 for no save, 1 for scratchdir, 2 for finaldir
% saveoption=[0]
% try dpi=150 for fast write, dpi=500 for publish quality
% dpi=[150]
% %where to saveimages for saveoption==1
% scratchdir=['/path/'];
% %where to saveimages for saveoption==2
% finaldir=['/path/'];
% %savename
% savename='PC1608-temperature-depth';
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