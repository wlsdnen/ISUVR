function DrawGraph( varargin )
%DRAWGRAPH 이 함수의 요약 설명 위치
%   자세한 설명 위치

persistent ACCELEROMTER_X ACCELEROMTER_Y ACCELEROMTER_Z
persistent LN_ACCELEROMTER_X LN_ACCELEROMTER_Y LN_ACCELEROMTER_Z
persistent GYROSCOPE_X GYROSCOPE_Y GYROSCOPE_Z
persistent UN_GYROSCOPE_X UN_GYROSCOPE_Y UN_GYROSCOPE_Z
persistent MAGNETOMETER_X MAGNETOMETER_Y MAGNETOMETER_Z
persistent UN_MAGNETOMETER_X UN_MAGNETOMETER_Y UN_MAGNETOMETER_Z
persistent LIGHT PRESSURE PROXIMITY
persistent GRAVITY_X GRAVITY_Y GRAVITY_Z
persistent ROTATION_VECTOR_X ROTATION_VECTOR_Y ROTATION_VECTOR_Z
persistent GAME_ROTATION_VECTOR_X GAME_ROTATION_VECTOR_Y GAME_ROTATION_VECTOR_Z
persistent ORIENTATION_AZIMUTH ORIENTATION_PITCH ORIENTATION_ROLL
persistent GEOMAGNETIC_ROTATION_VECTOR_X GEOMAGNETIC_ROTATION_VECTOR_Y GEOMAGNETIC_ROTATION_VECTOR_Z

if length(varargin) == 2
    idx = varargin{2};
    colorValue = rand(1,3);
    graphObj = varargin{1}.AxesGraph;
    
    axes (graphObj);
    switch idx
        case 1
            ACCELEROMTER_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            ACCELEROMTER_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            ACCELEROMTER_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 2
            MAGNETOMETER_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            MAGNETOMETER_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            MAGNETOMETER_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 3
            ORIENTATION_AZIMUTH = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            ORIENTATION_PITCH = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            ORIENTATION_ROLL = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 4
            GYROSCOPE_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GYROSCOPE_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GYROSCOPE_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 5
            LIGHT = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 6
            PRESSURE = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 8
            PROXIMITY = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 9
            GRAVITY_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GRAVITY_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GRAVITY_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 10
            LN_ACCELEROMTER_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            LN_ACCELEROMTER_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            LN_ACCELEROMTER_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 11
            ROTATION_VECTOR_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            ROTATION_VECTOR_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            ROTATION_VECTOR_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 14
            MAGNETOMETER_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            MAGNETOMETER_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            MAGNETOMETER_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            UN_MAGNETOMETER_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            UN_MAGNETOMETER_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            UN_MAGNETOMETER_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 15
            GAME_ROTATION_VECTOR_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GAME_ROTATION_VECTOR_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GAME_ROTATION_VECTOR_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 16
            UN_GYROSCOPE_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            UN_GYROSCOPE_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            UN_GYROSCOPE_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GYROSCOPE_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GYROSCOPE_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GYROSCOPE_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
        case 20
            GEOMAGNETIC_ROTATION_VECTOR_X = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GEOMAGNETIC_ROTATION_VECTOR_Y = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
            GEOMAGNETIC_ROTATION_VECTOR_Z = animatedline(graphObj,'Color',colorValue,'MaximumNumPoints', Inf);
    end
    
else
    idx = varargin{1};
    
    if length(varargin) > 1
        switch idx
            case 1
                addpoints(ACCELEROMTER_X, varargin{2}, varargin{3}(1));
                addpoints(ACCELEROMTER_Y, varargin{2}, varargin{3}(2));
                addpoints(ACCELEROMTER_Z, varargin{2}, varargin{3}(3));
            case 2
                addpoints(MAGNETOMETER_X, varargin{2}, varargin{3}(1));
                addpoints(MAGNETOMETER_Y, varargin{2}, varargin{3}(2));
                addpoints(MAGNETOMETER_Z, varargin{2}, varargin{3}(3));
            case 3
                addpoints(ORIENTATION_AZIMUTH, varargin{2}, varargin{3}(1));
                addpoints(ORIENTATION_PITCH, varargin{2}, varargin{3}(2));
                addpoints(ORIENTATION_ROLL, varargin{2}, varargin{3}(3));
            case 4
                addpoints(GYROSCOPE_X, varargin{2}, varargin{3}(1));
                addpoints(GYROSCOPE_Y, varargin{2}, varargin{3}(2));
                addpoints(GYROSCOPE_Z, varargin{2}, varargin{3}(3));
            case 5
                addpoints(LIGHT, varargin{2}, varargin{3});
            case 6
                addpoints(PRESSURE, varargin{2}, varargin{3});
            case 8
                addpoints(PROXIMITY, varargin{2}, varargin{3});
            case 9
                addpoints(GRAVITY_X, varargin{2}, varargin{3}(1));
                addpoints(GRAVITY_Y, varargin{2}, varargin{3}(2));
                addpoints(GRAVITY_Z, varargin{2}, varargin{3}(3));
            case 10
                addpoints(LN_ACCELEROMTER_X, varargin{2}, varargin{3}(1));
                addpoints(LN_ACCELEROMTER_Y, varargin{2}, varargin{3}(2));
                addpoints(LN_ACCELEROMTER_Z, varargin{2}, varargin{3}(3));
            case 11
                addpoints(ROTATION_VECTOR_X, varargin{2}, varargin{3}(1));
                addpoints(ROTATION_VECTOR_Y, varargin{2}, varargin{3}(2));
                addpoints(ROTATION_VECTOR_Z, varargin{2}, varargin{3}(3));
            case 14
                addpoints(UN_MAGNETOMETER_X, varargin{2}, varargin{3}(1));
                addpoints(UN_MAGNETOMETER_Y, varargin{2}, varargin{3}(2));
                addpoints(UN_MAGNETOMETER_Z, varargin{2}, varargin{3}(3));
                addpoints(MAGNETOMETER_X, varargin{2}, varargin{3}(4));
                addpoints(MAGNETOMETER_Y, varargin{2}, varargin{3}(5));
                addpoints(MAGNETOMETER_Z, varargin{2}, varargin{3}(6));
            case 15
                addpoints(GAME_ROTATION_VECTOR_X, varargin{2}, varargin{3}(1));
                addpoints(GAME_ROTATION_VECTOR_Y, varargin{2}, varargin{3}(2));
                addpoints(GAME_ROTATION_VECTOR_Z, varargin{2}, varargin{3}(3));
            case 16
                addpoints(UN_GYROSCOPE_X, varargin{2}, varargin{3}(1));
                addpoints(UN_GYROSCOPE_Y, varargin{2}, varargin{3}(2));
                addpoints(UN_GYROSCOPE_Z, varargin{2}, varargin{3}(3));
                addpoints(GYROSCOPE_X, varargin{2}, varargin{3}(4));
                addpoints(GYROSCOPE_Y, varargin{2}, varargin{3}(5));
                addpoints(GYROSCOPE_Z, varargin{2}, varargin{3}(6));
            case 20
                addpoints(GEOMAGNETIC_ROTATION_VECTOR_X, varargin{2}, varargin{3}(1));
                addpoints(GEOMAGNETIC_ROTATION_VECTOR_Y, varargin{2}, varargin{3}(2));
                addpoints(GEOMAGNETIC_ROTATION_VECTOR_Z, varargin{2}, varargin{3}(3));
        end
    else
        switch idx
            case 1
                clearpoints(ACCELEROMTER_X);
                clearpoints(ACCELEROMTER_Y);
                clearpoints(ACCELEROMTER_Z);
            case 2
                clearpoints(MAGNETOMETER_X);
                clearpoints(MAGNETOMETER_Y);
                clearpoints(MAGNETOMETER_Z);
            case 3
                clearpoints(ORIENTATION_AZIMUTH);
                clearpoints(ORIENTATION_PITCH);
                clearpoints(ORIENTATION_ROLL);
            case 4
                clearpoints(GYROSCOPE_X);
                clearpoints(GYROSCOPE_Y);
                clearpoints(GYROSCOPE_Z);
            case 5
                clearpoints(LIGHT);
            case 6
                clearpoints(PRESSURE);
            case 8
                clearpoints(PROXIMITY);
            case 9
                clearpoints(GRAVITY_X);
                clearpoints(GRAVITY_Y);
                clearpoints(GRAVITY_Z);
            case 10
                clearpoints(LN_ACCELEROMTER_X);
                clearpoints(LN_ACCELEROMTER_Y);
                clearpoints(LN_ACCELEROMTER_Z);
            case 11
                clearpoints(ROTATION_VECTOR_X);
                clearpoints(ROTATION_VECTOR_Y);
                clearpoints(ROTATION_VECTOR_Z);
            case 14
                clearpoints(UN_MAGNETOMETER_X);
                clearpoints(UN_MAGNETOMETER_Y);
                clearpoints(UN_MAGNETOMETER_Z);
                clearpoints(MAGNETOMETER_X);
                clearpoints(MAGNETOMETER_Y);
                clearpoints(MAGNETOMETER_Z);
            case 15
                clearpoints(GAME_ROTATION_VECTOR_X);
                clearpoints(GAME_ROTATION_VECTOR_Y);
                clearpoints(GAME_ROTATION_VECTOR_Z);
            case 16
                clearpoints(UN_GYROSCOPE_X);
                clearpoints(UN_GYROSCOPE_Y);
                clearpoints(UN_GYROSCOPE_Z);
                clearpoints(GYROSCOPE_X);
                clearpoints(GYROSCOPE_Y);
                clearpoints(GYROSCOPE_Z);
            case 20
                clearpoints(GEOMAGNETIC_ROTATION_VECTOR_X);
                clearpoints(GEOMAGNETIC_ROTATION_VECTOR_Y);
                clearpoints(GEOMAGNETIC_ROTATION_VECTOR_Z);
        end
    end
end


end

