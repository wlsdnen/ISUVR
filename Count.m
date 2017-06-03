function [ num ] = Count( a_svm, g_svm, yaw )
%COUNT 이 함수의 요약 설명 위치
%   자세한 설명 위치
%Resetting MATLAB environment
warning off;

svm = a_svm .* g_svm;

svmThresholdMax = 10;
YawThreshold = 0.5;

windows = 50;
index = 1;
EatingCount = 0;

svmFirstIdx = 0;
svmSecondIdx = 0;

yawMaxIDX = 0;
yawMinIDX = 0;
yawSecondIdx = 0;

svmFirstFlag = 0;
svmSecondFlag = 0;
yawUpFlag = 0;
yawDnFlag = 0;

while index+windows<length(svm)
        
    [value, locs] = findpeaks(svm(index:index+windows),'SortStr','descend', 'NPeaks',  1, 'MinPeakHeight',svmThresholdMax*0.4, 'MinPeakDistance',30);
    [value1, locs1] = findpeaks(yaw(index:index+windows),'SortStr','descend', 'NPeaks',  1, 'MinPeakHeight',YawThreshold*0.3, 'MinPeakDistance',30);
    [value2, locs2] = findpeaks(-yaw(index:index+windows),'SortStr','descend', 'NPeaks',  1, 'MinPeakHeight',YawThreshold*0.3, 'MinPeakDistance',30);

    if ~isempty (value) && ~isempty(locs)
        if index+locs-svmFirstIdx > 50 && svmSecondFlag ~= 1
            svmFirstIdx = index-1+locs;
            svmFirstFlag = 1;
        end
    end
    
    if ~isempty (value) && ~isempty(locs) ~= 0
        if index+locs-svmSecondIdx > 50 && svmFirstFlag
            svmSecondIdx = index-1+locs;
            svmSecondFlag = 1;            
        end
    end
    
    if ~isempty (value1) && ~isempty(locs1) ~= 0 && yawDnFlag ~= 1
        if index+locs1-yawMaxIDX > 50
            yawMaxIDX = index-1+locs1;
            yawUpFlag = 1;
        end
    end
    
    if ~isempty (value2) && ~isempty(locs2) ~= 0 && yawUpFlag
        if index+locs2-yawMinIDX > 50
            yawMinIDX = index-1+locs2;
            yawDnFlag = 1;
        end
    end
    
    if svmFirstFlag && svmSecondFlag && yawDnFlag && yawDnFlag 
        svmFirstFlag = 0;
        svmSecondFlag = 0;
        yawUpFlag = 0;
        yawDnFlag = 0;
        EatingCount = EatingCount + 1;
        
        [svmMinValue, svmMinLoc] = min (svm(svmFirstIdx:svmSecondIdx));
        svmMinLoc = (svmFirstIdx+svmMinLoc-1);
        svmThresholdMax = 0.75*svmThresholdMax + 0.25*((svm(svmFirstIdx)+ svm(svmSecondIdx))*0.5);
        YawThreshold = 0.75*YawThreshold + 0.25*(abs(yaw(yawMaxIDX)) + abs(yaw(yawMinIDX)) * 0.5);
    end
    index = index + windows;
end
num = EatingCount

end