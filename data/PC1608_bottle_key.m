% key for PC1608_bottle

m=matfile('PC1608_data.mat');
data=m.PC1608_bottle;

station_b=data(:,1); % station
year_b=data(:,2); % year
month_b=data(:,3); % month
day_b=data(:,4); % day
time_b=data(:,5); % local time
lat_b=data(:,10); % lat (decimal degrees)
long_b=data(:,11); % long (decimal degrees)
bd_b=data(:,12); % bottom depth (meters)
bottle_b=data(:,13); % bottle number
rsd_b=data(:,14); % recorded sampling depth (meters)
chlorid_b=data(:,15); % vial #, when present, for chlorophyll
chloro_b=data(:,16); % chlorophyll (ug/L)
phaeo_b=data(:,17); % phaeopigment (ug/L)
vial_b=data(:,18); % vial number for seawater sample
NO3_b=data(:,19); % NO3 (umol/L)
SiO2_b=data(:,20); % SiO2 (umol/L)
NH4_b=data(:,21); % NH4 (umol/L)
PO4_b=data(:,22); % PO4 (umol/L)
SP_b=data(:,23); % practical salinity (psu)
sigmatheta_b=data(:,24); % potential density (kg/m^3)
p_b=data(:,25); % pressure(dbar)
t_b=data(:,26); % in situ temperature (degrees celsius)
cond_b=data(:,27); % conductivity (mS/cm)
fluor_b=data(:,28); % fluorescence (volts)
tvolts_b=data(:,29); % beam transmission (volts)
oxygen_b=data(:,30); % dissolved oxygen (mg/L)