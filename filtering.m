acc = dlmread ('06-Mar-2017 204627_MPU6515 Accelerometer.txt');
gyro = dlmread ('06-Mar-2017 204137_MPU6515 Gyroscope.txt');
 
%  ano    = dlmread ('02-Mar-2017 111118_MPU6515 Accelerometer_ann.txt');

accelX = sum (abs (acc (:, 1)) * 0.02) *.02 * length(accelX)
accelY = sum (abs (acc (:, 2)) * 0.02) *.02 * length(accelY)
accelZ = sum (abs (acc (:, 3)) * 0.02) *.02 * length(accelZ)
gyroX = sum (abs (gyro (:, 1)) * 0.02 * 180/pi)
gyroY = sum (abs (gyro (:, 2)) * 0.02 * 180/pi)
gyroZ  = sum (abs (gyro (:, 3)) * 0.02 * 180/pi)


%  hold on
%  plot (sqrt (acc(:,1).^2 + acc(:,2).^2 + acc(:,3).^2))
% plot (gyro)
%  plot (ano', 'o');
%  hold off
%  gyr    = dlmread ('28-Feb-2017 131424_MPU6515 Gyroscope.txt');
%  mag = dlmread ('28-Feb-2017 131424_AK8963 Magnetometer.txt');
%  rot = dlmread ('28-Feb-2017 131424_Rotation Vector.txt');
%  ori = dlmread ('28-Feb-2017 131424_Orientation.txt');
%  
%  hold on
%  subplot (5, 1, 1);
%  plot (acc);
%  title ('Accelerometer');
%  
%  subplot (5, 1, 2);
%  plot (gyr)
%  title ('Gyroscope');
%  
%  subplot (5, 1, 3);
%  plot (mag)
%  title ('Magnetometer');
% 
%  
%  subplot (5, 1, 4);
%  plot (ori)
%  title ('Orientation');
% 
%  
%  subplot (5, 1, 5);
%  plot (rot)
%  title ('Rotation Vector');
% 
%  
%  hold off
 
% 
%  gyr = resample (gyr, length(acc), length(gyr));
%  mag = resample (mag, length(acc), length(mag));
%  
%  data = [];
%  data2 = [];
%  data3 = [];
%  
%  
%  for i = 1:length(gyr)
%      [x, y, z] =  LPF( acc(i,1),  acc(i,2),  acc(i,3));
%      [x2, y2, z2] =  MovAvgFilter( gyr(i,1),  gyr(i,2),  gyr(i,3));
%      %      [x3, y3, z3] =  LPF3( mag(i,1),  mag(i,2),  mag(i,3));
%      am = sqrt (x.^2 + y.^2 + z.^2);
%      gm = sqrt (x2.^2 + y2.^2 + z2.^2);
%      data = [data; am];
%      data2 = [data2; gm];
%      data3 = [data3; z2];
% %      data3 = [data3; x3, y3, z3];
%  end
%  
%  
%  hold on
%  plot (data .* data2)
% %  plot (data2)
%  plot (data3)
%  hold off