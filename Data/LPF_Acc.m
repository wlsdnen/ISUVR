function [xlpf, ylpf, zlpf] = LPF(x, y, z)
%
%
persistent prevX
persistent prevY
persistent prevZ
persistent firstRun

%initialize
if isempty(firstRun)
    prevX = x;
    prevY = y;
    prevZ = z;
    firstRun = 1;
end

% constant 'a'
alpha = 0.8;

xlpf = alpha * prevX + (1-alpha)*x;
ylpf = alpha * prevY + (1-alpha)*y;
zlpf = alpha * prevZ + (1-alpha)*z;

prevX = xlpf;
prevY = ylpf;
prevZ = zlpf;

end
