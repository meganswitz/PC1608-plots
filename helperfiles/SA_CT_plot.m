function SA_CT_plot_contours_manual(p_ref,isopycs,title_string,SA_min,SA_max,CT_min,CT_max)
%
% This function is modofied from the gsw_SA_CT_plot function (VERSION NUMBER: 3.05 (27th January 2015)
% The biggest differnence is that I removed the functionality for automatically plotting lines 
% and automatically calculating the minimum and maximum temperature and salinity bounds. This basically
% plots a box with lines of constant density that you can plot data on top of. 
% 
% Requires GSW Oceanographic Toolbox (to calculate rho)
% The software is available from http://www.TEOS-10.org
%
% INPUT:
% p_ref = reference sea pressure for the isopycnals        [ dbar ]
% title_string = title, can be set to [] for no title      [      ]
% SA_min  =  minimum salinity for plotting                 [ g/kg ]
% SA_max  =  maximum salinity for plotting                 [ g/kg ]
% CT_min  =  minimum temperature for plotting              [ deg C ]
% CT_max  =  maximum temperature for plotting              [ deg C ]


SA_axis = [SA_min:(SA_max-SA_min)/200:SA_max];
CT_axis = [CT_min:(CT_max-CT_min)/200:CT_max];

SA_gridded = meshgrid(SA_axis,1:length(CT_axis));
CT_gridded = meshgrid(CT_axis,1:length(SA_axis))';

isopycs_gridded = gsw_rho(SA_gridded,CT_gridded,p_ref)-1000;


[c1,h] = contour(SA_gridded,CT_gridded,isopycs_gridded,isopycs,':','Color',[0 0 0]);


hold on;

% set density line label specs
if exist('c1','var')
    clabel(c1,h,'labelspacing',300,'fontsize',12,'color',[0 0 0]);
end

% label axes and add title if exists
axis('square');
axis([SA_min SA_max CT_min CT_max]);
xlabel('Salinity (g{\cdot}kg^-^1)','fontsize',24);
ylabel('Temperature ({\circ}C)','fontsize',24);
if exist('title_string','var')
    title([title_string],'fontsize',14);
end

% tick specs
set(gca,'tickdir','out');


% reference pressure label
txt = text(0.01,0.99,[' p_r_e_f = ' int2str(p_ref) ' dbar'], ...
    'horiz','left','Vert','top','units','normalized','color',[0 0 0]);
txt_fs = get(txt,'fontsize');
set(txt,'fontsize',14);

% x tick labels
xl = get(gca,'XLabel');
xlFontSize = get(xl,'FontSize');
xAX = get(gca,'XAxis');
set(xAX,'FontSize', 14)
set(xl, 'FontSize', xlFontSize);

% y tick labels
yl = get(gca,'YLabel');
ylFontSize = get(xl,'FontSize');
yAX = get(gca,'YAxis');
set(yAX,'FontSize', 14)
set(yl, 'FontSize', ylFontSize);


end