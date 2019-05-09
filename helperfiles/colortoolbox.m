%% colortoolbox

%% default colors for PC1608 manuscript are listed at the bottom 

%% To set an alpha value for lines in matlab, alpha must be included in RGB specs, but colors for markers can only include 3 elements.
%% To define alpha values for line in script, first define lalpha and then run colortoolbox.m 
%% Lines below set default alpha=1 so colortoolbox works when there is no lalpha value defined by user.
if ~exist('lalpha'),
	lalpha=1;
end
%

%%%% set of colors to use for plotting %%%%

%colors from wong colorblind palette
worange=[.835, .369, 0];
wsky=[0, .447, .698];
wyellow=[.941, .894, .259];

%colors frm wong colorblind palette, plus alpha
tworange=[.835, .369, 0, lalpha];
twsky=[0, .447, .698, lalpha];
twyellow=[.941, .894, .259, lalpha];

%colorblind colors
brightgreen=[.102,1,.102];
tbrightgreen=[.102,1,.102,lalpha];
brightpurple=[.467, .106, .808];
tbrightpurple=[.467, .106, .808, lalpha];
mint=[.106,.620,.467];
tmint=[.106,.620,.467,lalpha];
mint2=[.133,.792,.596];
tmint2=[.133,.792,.596,lalpha];
orange2=[.851,.373,.008];
torange2=[.851,.373,.008,lalpha];
orange3=[.949,.416,.008];
torange3=[.949,.416,.008,lalpha];
lavender=[.459,.439,.702];
tlavender=[.459,.439,.702,lalpha];

%parula colors

pnavy=[0.2081, 0.1663, 0.5292];
psky=[0.0795, 0.5159, 0.8328];
pteal=[0.1986, 0.7214, 0.6310];
pgold=[0.8266, 0.7320, 0.3464];
pyellow=[0.9763, 0.9831, 0.0538];
ppurple=[.278, .173, .478];

%transparent parula colors for lines

tpnavy=[0.2081, 0.1663, 0.5292, lalpha];
tpsky=[0.0795, 0.5159, 0.8328, lalpha];
tpteal=[0.1986, 0.7214, 0.6310, lalpha];
tpgold=[0.8266, 0.7320, 0.3464, lalpha];
tpyellow=[0.9763, 0.9831, 0.0538, lalpha];
tblack=[0,0,0,lalpha];
tpink=[0.75, 0, 0.75,lalpha];
tppurple=[.278, .173, .478, lalpha];

%regular colors
blue=[0, 0.4470, 0.7410];
orange=[0.91,0.41,0.17];
green=[0.4660, 0.6740, 0.1880];
pink=[0.75, 0, 0.75];
yellow=[0.9290, 0.6940, 0.1250];
grey=[0.3,0.3,0.3];
black=[0,0,0];
mwhite=[1,1,1];

%%%% default colors for PC1608 nutrients manuscript %%%%

GB_m_color=brightpurple;
JB_m_color=mint;
WB_m_color=orange3;
allother_m_color=black;

GB_l_color=tbrightpurple;
JB_l_color=tmint;
WB_l_color=torange3;
allother_l_color=tblack;

black=[0,0,0];
mwhite=[1,1,1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





