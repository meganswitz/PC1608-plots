% key for PC1608_bsi

m=matfile('PC1608_data.mat');
data=m.PC1608_bsi;

BSi_vial=data(:,1); % vial number for BSi analysis in the lab
BSi_sta=data(:,2); % station number
BSi_lat=data(:,3); % latitude
BSi_lon=data(:,4); % longitude
BSi_temp=data(:,5); % in-situ temperature
BSi_sal=data(:,6); % salinity (psu)
BSi_depth=data(:,7); % depth (m)
BSi_NO3=data(:,8); % NO3 of seawater
BSi_SiO2=data(:,9); % SiO2 of seawater
BSi_val=data(:,10); % biogenic silica value
BSi_rsd=data(:,11); % recorded sampling depth
BSi_rbd=data(:,12); %recorded bottom depth
