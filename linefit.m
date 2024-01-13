clear all
close all
clc
%% 

npoly=14;

%% 
hd5fp = 'hps.hd5'; %strcat(basedir +  fpn(1) + '/hps.hd5')

h5disp(hd5fp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% initialize stuff (???? ) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%read inter helical parameters
inter=h5read(hd5fp,'/inter');
% reorganize all the data into a single set that we'll manipulate
data=vertcat(inter.Roll);
%%setting up our specific position
%xmin = 15 + pm*shift
xmin=15-6 %getting position plus 2 for my assignment.SHOULD THIS BE 177?
xmax=xmin+146
data=data(xmin:xmax,:);
[xdim,ydim]=size(data);
xrange=xmax-xmin;
xvals=-xrange/2:xrange/2;
norm = range(xrange);
meanvals =mean(data,2);
maxvals=max(data,[],2); %M = max(A, [], 'all'); %taken from reference section
minvals=min(data,[],2);
stdvals=std(data,[],2);
%b=data(meanvals);
b=meanvals;

Z = ones(xdim,npoly);
for np = 2:npoly+1
    tmp = meanvals.^(np-1)%+sin(2*pi*np.*xvals/xrange);
    %norm = sqrt(dot(tmp,tmp));
    Z(:,np) = tmp;
end
coeffs = (Z'*Z)\(Z'*b);

%coeffs(1:4)=0

plot(xvals,Z*coeffs,xvals,b)
legend("approx","data")
