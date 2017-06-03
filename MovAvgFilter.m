function [avgX, avgY, avgZ ] = MovAvgFilter(x, y, z)

persistent n xbuf ybuf zbuf
persistent sumX sumY sumZ
persistent firstRun

if isempty (firstRun)
    n = 50;
    xbuf = x*ones(n+1,1);
    ybuf = y*ones(n+1,1);
    zbuf = z*ones(n+1,1);
    firstRun = 1;
    sumX = 0;
    sumY = 0;
    sumZ = 0;
end

for m=1:n
    xbuf(m) = xbuf(m+1);
    sumX = sumX + xbuf(m+1);
    
    ybuf(m) = ybuf(m+1);
    sumY = sumY + ybuf(m+1);
    
    zbuf(m) = zbuf(m+1);
    sumZ = sumZ + zbuf(m+1);
end

xbuf(n+1) = x;
sumX = sumX + xbuf(n+1);

ybuf(n+1) = y;
sumY = sumY + ybuf(n+1);

zbuf(n+1) = z;
sumZ = sumZ + zbuf(n+1);

avgX = sumX/n;
avgY = sumY/n;
avgZ = sumZ/n;

sumX = 0;
sumY = 0;
sumZ = 0;
