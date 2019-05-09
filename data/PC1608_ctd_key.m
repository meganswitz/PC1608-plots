% key for PC1608_ctd

m=matfile('PC1608_data.mat');
data=m.PC1608_ctd;

sta_c=data(:,1); % station
lat_c=data(:,2); % latitude (decimal degrees)
long_c=data(:,3); % longitude (decimal degrees)
p_c=data(:,4); % pressure (psi)
t1_c=data(:,5); % in-situ temperature from sensor 1 (degrees Celsius)
t2_c=data(:,6); % in-situ temperature from sensor 2 (degrees Celsius)
SP1_c=data(:,7); % practical salinity for salinity sensor 1 (psu)
SP2_c=data(:,8); % practical salinity for salinity sensor 2 (psu)
depth_c=data(:,9); % depth (meters)
soundvelocity_c=data(:,10); % sound velocity (Chen-Millero, m/s)
oxygen1_c=data(:,11); % dissolved oxygen from sensor 1 (mg/L)
oxygen2_c=data(:,12); % dissolved oxygen from sensor 2 (mg/L)
cond_c=data(:,13); % conductivity (mS/sm)
alt_c=data(:,14); % altimeter (meters)
fluor_c=data(:,15); % fluorescence (volts) 
xmiss_c=data(:,16); % beam transmission (volts)
bposition_c=data(:,17); % bottle position (not recorded here)
sigmatheta_c=data(:,18); % potential density (kg/m^3)