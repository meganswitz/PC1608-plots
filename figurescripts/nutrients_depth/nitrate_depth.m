% script plots nitrate with depth for all discrete bottling samples
%
% requires PC1608_data.mat
% requires PC1608_bottle_key.m
% requires colortoolbox.m
%
% code is written this way in order to plot transparent markers over each other without seeing lines behind them
% see section at the bottom for saving options
%
% Make sure to add path for all files necessary to run script. 

figure(1)
clf

% sample key loads data necessary for plotting
run PC1608_bottle_key;

% select attribute for plotting
attribute=NO3_b;

% key of cast numbers for each region
GBcasts=[34:43]; % Georges Basin region
JBcasts=[19:24]; % Jordan Basin region
WBcasts=[5:7]; % Wilkinson Basin region
allothercasts=[1:4 8:18 25:33 44]; % all other casts

% pick cast numbers to plot (or can use key above)
region=[1:44];

% plot castlines for nutrient points? 1/0
castlines=1;

%linespecs
ms=85; % marker size
lw=2; % linewidth for bottle data
lwc=2; % linewidth for ctd data
alpha=.7; % alpha for markerface
lalpha=.7; % alpha for lines

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
xlim([0 25]);
ylim([0 370]);
xlabel(['\fontsize{24}Nitrate (' char(181) '\fontsize{24}M)']);
ylabel('\fontsize{24}Depth (m)');

% begin plotting

% lines
if castlines==1  
    for k=region
        rows=find(station_b==k);
        %plot lines
        if ismember(k,GBcasts)==1
            plot(attribute(rows),p_b(rows),'LineStyle','-','Color',GB_l_color,'Linewidth',lw)
        elseif ismember(k,JBcasts)==1
            plot(attribute(rows),p_b(rows),'LineStyle','-','Color',JB_l_color,'Linewidth',lw)
        elseif ismember(k,WBcasts)==1
            plot(attribute(rows),p_b(rows),'LineStyle','-','Color',WB_l_color,'Linewidth',lw)
        elseif ismember(k,allothercasts)==1
            plot(attribute(rows),p_b(rows),'LineStyle','-','Color',allother_l_color,'Linewidth',lw)
        end
    end  
end

% plot white filled markers for bottle data 

for k=region
    rows=find(station_b==k); 
    scatter(attribute(rows),p_b(rows),ms,'MarkerFaceColor',mwhite,'MarkerEdgeColor',mwhite)
end
    
% plot colored markers for bottle data
  
for k=region
   rows=find(station_b==k); 
   % %plot colored edge markers
    if ismember(k,GBcasts)==1
        scatter(attribute(rows),p_b(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',GB_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);
    elseif ismember(k,JBcasts)==1
        scatter(attribute(rows),p_b(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',JB_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);
    elseif ismember(k,WBcasts)==1
        scatter(attribute(rows),p_b(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',WB_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);
    elseif ismember(k,allothercasts)==1
        scatter(attribute(rows),p_b(rows),ms,'MarkerEdgeColor',black,'MarkerFaceColor',allother_m_color,'MarkerFaceAlpha',alpha,'MarkerEdgeAlpha',alpha);
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
set(l,'Location','southwest');
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
% savename='PC1608-totalnitrate-depth';
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