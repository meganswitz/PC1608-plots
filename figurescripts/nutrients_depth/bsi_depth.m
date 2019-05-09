% script plots biogenic silica with depth for all available samples
%
% requires PC1608_data.mat
% requires PC1608_bsi_key.m
% requires colortoolbox.m
%
% NOTE: missing filters for stations 12, 33, and 38. Two fiters for station 6. 
%
% code is written this way in order to plot transparent markers over each other without seeing lines behind them
% see section at the bottom for saving options
%
% Make sure to add path for all files necessary to run script. 

figure(1)
clf

% sample key loads data necessary for plotting
run PC1608_bsi_key.m;

% select attribute for plotting
attribute=BSi_val;

% key of cast numbers for each region
GBcasts=[34:43]; % Georges Basin region
JBcasts=[19:24]; % Jordan Basin region
WBcasts=[5:7]; % Wilkinson Basin region
allothercasts=[1:4 8:18 25:33 44]; % all other casts

%pick cast numbers to plot (can use key above) %for this series of plots, make sure region here matches script name and title
region=[1:44];

%linespecs
ms=200;
lw=2;
lwc=2;
alpha=.7;
lalpha=.7;

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

hold on

% limits and labels for a and y axes
xlim([0 3])
ylim([0 370]);
xlabel(['\fontsize{24}Biogenic silica (' char(181) '\fontsize{24}M)']);
ylabel('\fontsize{24}Depth (m)');

for k=region

	 rows=find(BSi_sta==k); 

if ismember(k,GBcasts)==1
            scatter(BSi_val(rows),BSi_depth(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',GB_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)
        elseif ismember(k,JBcasts)==1
            scatter(BSi_val(rows),BSi_depth(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',JB_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)
        elseif ismember(k,WBcasts)==1
            scatter(BSi_val(rows),BSi_depth(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',WB_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)
        elseif ismember(k,allothercasts)==1
            scatter(BSi_val(rows),BSi_depth(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',allother_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha)
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

% fake points for legend
GBl=plot([100:200],[100:200],'Linestyle','-','Color',GB_m_color,'MarkerFaceColor',GB_m_color,'Linewidth',5);
JBl=plot([100:200],[100:200],'Linestyle','-','Color',JB_m_color,'MarkerFaceColor',JB_m_color,'Linewidth',5);
WBl=plot([100:200],[100:200],'Linestyle','-','Color',WB_m_color,'MarkerFaceColor',WB_m_color,'Linewidth',5);
allotherl=plot([100:200],[100:200],'Linestyle','-','Color',allother_m_color,'MarkerFaceColor',allother_m_color,'Linewidth',5);

% legend from fake points
l=legend([GBl, JBl, WBl, allotherl],label_GB, label_JB, label_WB, label_allother);
set(l,'FontSize',14);
set(l,'Location','southeast');
legend('boxoff')


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
% savename='PC1608-BSi-depth';
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