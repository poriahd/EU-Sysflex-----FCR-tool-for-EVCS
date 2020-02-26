function [Data,NoEvemt,NoDay,Date] = PD_LoadData(FileName)
% This function will load and clean new data

%% Read new data from the excell file
[~,~,RawData] = xlsread(FileName);
% Remove Header
RawData(1,:) = [];
% Remove empty raws
RawData(isnan(cell2mat(RawData(:,1))),:) = [];

% Add 0.0.0 for the time does not have hours
for Cnt = 1:size(RawData,1)
    if size(RawData{Cnt,3},2) < 10
        RawData{Cnt,3} = [RawData{Cnt,3} ' 0.0.0'];
    end
    if size(RawData{Cnt,4},2) < 10
        RawData{Cnt,4} = [RawData{Cnt,4} ' 0.0.0'];
    end
end
  
%% Change the data structure
Data(:,1:6) = datevec(datetime(RawData(:,3),...
    'InputFormat','dd.MM.yyyy HH.mm.SS'));
Data(:,7:12) = datevec(datetime(RawData(:,4),...
    'InputFormat','dd.MM.yyyy HH.mm.SS'));
Data(:,13:16) = [cell2mat(RawData(:,1:2)) cell2mat(RawData(:,5:6))];
Data(:,17) = etime(Data(:,7:12),Data(:,1:6))/3600;   % plugged-in in hours
Data(:,18)  = (Data(:,15)/1000)./Data(:,17);   % Pluged average power (kw)

% Remove miss data, which replaced by NAN in datetime
for Cnt= 1:18
    Data(isnan(Data(:,Cnt)),:) = [];
end

%% Clean meaningless data

% Remove repeated data in the new data
Data = unique(Data,'rows');

% Remove event shorter than 5 minutes or 
% longer than 24 hours
% Having Energy less than 0.1 kW
% Having Energy more than 100 kw
% unknown parking or departure time

TempIn = Data(:,17)<0.0833 |  isnan(Data(:,17)) | ...
    Data(:,15)<100 | Data(:,15)>100000 | ...
     Data(:,18)>Data(:,16);

Data(logical(TempIn),:) = [];

%% Sort Data based on the arrival time 

if size(Data,1) > 0
    Time = datetime(datestr(Data(:,1:6)));
    [~,TempIn] = sort(Time);
    Data = Data(TempIn,:);
end

NoEvemt = size(Data,1);
temp = char(between(datetime(Data(1,1:3)),datetime(Data(end,1:3))+1,'days'));
NoDay = str2double(temp(1:end-1));
temp = char(datetime(Data(end,1:3))+1);
Date = temp(1:11);



