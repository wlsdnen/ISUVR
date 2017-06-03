acc = dlmread ('02-Jun-2017 180928_Linear Acceleration.txt');
gyro = dlmread ('02-Jun-2017 180928_MPU6515 Gyroscope.txt');

acc_f = [];
gyro_f = [];

a_svm = [];
g_svm = [];
a_g_svm = [];

for i = 1:length (acc)
   
    [acc_f(end+1, 1), acc_f(end, 2), acc_f(end, 3)] = LPF_Acc (acc(i,1), acc(i,2), acc(i,3));
    [gyro_f(end+1, 1), gyro_f(end, 2), gyro_f(end, 3)] = LPF_Gyro (gyro(i,1), gyro(i,2), gyro(i,3));
    
    a_svm(end+1) = sqrt(acc_f(i,1).^2 + acc_f(i,2).^2 + acc_f(i,3).^2);
    g_svm(end+1) = sqrt(gyro_f(i,1).^2 + gyro_f(i,2).^2 + gyro_f(i,3).^2);
    a_g_svm(end+1) = a_svm(end) .* g_svm(end);
    
end

figure
subplot (6,1,1)
plot (acc_f(1:1000, 2))
legend ('Accelerometer Y')

subplot (6,1,2)
plot (acc_f(1:1000, 3))
legend ('Accelerometer Z')

subplot (6,1,3)
plot (gyro_f(1:1000, 1))
legend ('Gyroscope X')

subplot (6,1,4)
plot (a_svm(1:1000))
legend ('a svm')

subplot (6,1,5)
plot (g_svm(1:1000))
legend ('g svm')

subplot (6,1,6)
plot (a_g_svm(1:1000))
legend ('a g svm')
