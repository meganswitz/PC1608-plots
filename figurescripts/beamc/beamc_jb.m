
% script creates a figure for beam transmission with depth for all the jordan basin region
%
% requires PC1608_data.mat
% requires PC1608_ctd_key.m
% requires colortoolbox.m
% 
% NOTE: Station 19 hit the bottom and we cut out the part of the cast that records the disturbed bottom sediment.
% NOTE: The data for station 23 appears to be compromised and we do not plot it.
%
% See section at the bottom for saving options.
%
% Make sure to add path for all files necessary to run script. 

figure(1)
clf

% sample key loads data necessary for plotting
run PC1608_ctd_key;

% process voltage to beam attenuation
% M and B calibration values from ctd file metadata at date of last calibration
M=21.2730;
B=-0.0850;

trans=((M*xmiss_c)+B)./100;
beamc_val=-(log(trans)./.25);

%pick attribute to plot
attribute=beamc_val;

%linespecs
ms=85; % marker size
lw=2; % linewidth tfor bottle data
lwc=2; % linewidth for ctd data
alpha=.7; % marker face alpha
lalpha=.7; % line alpha

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

%pick cast numbers to plot (can use key above) %for this series of plots, each plot is one region.
region=[JBcasts];

hold on

% limits and labels for x and y axes
xlim([0 1.8]);
ylim([0 370]);
xlabel('\fontsize{28}Beam attenuation (c)');
ylabel('\fontsize{28}Depth (m)');

for k=region
    
    rows=find(sta_c==k);   
    
    if ismember(k,[34:43])==1
        plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',GB_l_color,'Linewidth',lwc)
    elseif ismember(k,[19:22 24])==1 % Compromised data for station 23, reason unknown. Do not include in plot.
        if ismember(k,19)==1
            rows2=find(depth_c(rows)<=210); % Remove data after CTD hit the bottom by only plotting above 210 meters.
            plot(attribute(rows(rows2)),depth_c(rows(rows2)),'LineStyle','-','Color',JB_l_color,'Linewidth',lw)
        else
            plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',JB_l_color,'Linewidth',lwc)
        end
    elseif ismember(k,[5:7])==1
        plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',WB_l_color,'Linewidth',lwc)
    elseif ismember(k,[1:4 8:18 25:33 44])==1
        plot(attribute(rows),depth_c(rows),'LineStyle','-','Color',allother_l_color,'Linewidth',lwc)
    end

end 

% specs for axes
set(gca,'Ydir','reverse')
set(gca,'XAxisLocation','top');

% specs for axes labels
xAX = get(gca,'XAxis');
set(xAX,'FontSize', 24)
yAX = get(gca,'YAxis');
set(yAX,'FontSize', 24)

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
% savename='PC1608-beamc-JB';
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

