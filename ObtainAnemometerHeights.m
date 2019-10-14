clear all
close all

cd C:\Work\Alert\Jebi2018\MS&AD

%importing file from Shimon
[StationCategory,Station,StationName,KatakanaName,Lat,Lon,LatDegree,LatMinute,LonDegree,LonMinute,Elevation,Precipitation,Wind,Temperature,Sunshine,Snowfall,VarName17,VarName18,VarName19,VarName20,Note1,Note2] = importfile_observations('obs_stations_UTF8.csv', 3, 1694);
clear KatakanaName LatDegree LatMinute LonDegree LonMinute Precipitation Temperature Sunshine Snowfall VarName17 VarName18 VarName19
clear VarName20 Wind Note1 Note2

%importing file from JMA
[Var1,JMAID,JMAType,JMAName,Var5,Var6,Var7,Var8,Var9,Var10,Var11,JMAanemometerHgt,Var13,Var14,Var15,Var16] = importfile_masterList('Amedas.csv', 2, 1328);
clear Var1 Var5 Var6 Var7 Var8 Var9 Var10 Var11 Var13 Var14 Var15 Var16


% %Need to match up 'AmedasName' with 'StationName'
% %Need to get anemometerHgt and assign to Station
data=[];
missing=[];
for i=1:length(StationName)
    m = strcmp(JMAName(:,1),StationName(i,1));
    row=find(m==1);    
    if (isempty(row)==0)
        dataID=Station(i,1);
        height=JMAanemometerHgt(row(1,1),1);
        temp=[dataID,height];
        data=[data;temp];
    else
        missing=[missing;Station(i,1)];
    end
end

data=unique(data,'rows');
missing=unique(missing);
dlmwrite('StationswHgt.csv',data,'precision',6);
dlmwrite('StationsnoHgt.csv',missing);