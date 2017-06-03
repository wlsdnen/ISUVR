function [ sensors, mapNameObj,  mapTypeObj] = ParseSensorInfo( input_args )
%PARSESENSORINFO 이 함수의 요약 설명 위치
%   자세한 설명 위치

input_sensors = strsplit (input_args, '|');
copy_sensors = {};

sensors = struct('index', {}, 'name', {}, 'power', {}, 'resolution', {}, 'range', {}, 'vendor', {}, 'version', {}, 'data', {}, 'annotation', {}, 'count', {});

for i=1:length(input_sensors)
    if strfind(input_sensors{i}, '-Wakeup Secondary')
        continue;
    end
    copy_sensors = [copy_sensors, input_sensors{i}];
end

keyNameSet = {};
valueTypeSet = [];

keyTypeSet = {};
valueIndexSet = [];

for i=1:length(copy_sensors)
    
    data = strsplit (copy_sensors{i}, ',');
    sensors(i).index = data{1};
    sensors(i).name = data{2};
    sensors(i).power = data{3};
    sensors(i).resolution = data{4};
    sensors(i).range = data{5};
    sensors(i).vendor = data{6};
    sensors(i).version = data{7};
    sensors(i).data = [];
    sensors(i).annotation = [];
    sensors(i).count = 0;
    
    keyNameSet{end+1} = sensors(i).name;
    valueTypeSet(end+1) = str2double(sensors(i).index);
    
    keyTypeSet{end+1} = sensors(i).index;
    valueIndexSet{end+1} = i;
        
end

mapNameObj = containers.Map(keyNameSet,valueTypeSet);
mapTypeObj =  containers.Map(keyTypeSet,valueIndexSet);