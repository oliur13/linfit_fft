%This code reads the hdf5 file, parses the data,
% and makes some plots

%clean everything before start
clear all
close all
clc

%%% this is the name of hte hd5file assigned to you
hd5fp = 'hps.hd5'
%%%%

%load the file
h5disp(hd5fp) %diplay hdf5 file to see what's inside
inter=h5read(hd5fp,'/inter'); %read inter helical parameters
%intra=h5read('pos11.hd5','/intra'); %read intra helical parameters
%%   there's more here than we'll use to ignore the rest.

%% assign 
% Roll=inter.Roll;

%% reorganize all the data into a single set that we'll manipulate

data=vertcat(inter.Roll);
xmin=176-147-6;
xmax=xmin+146;
data=data(xmin:xmax,:);
plot(data(:,500))
namelist={ 'Roll'};

%% set up some info for plotting etc.
%% there are 6 sets of data eaqch 100,000 by 147 in size
%%   we regroup into 10 sets of 147*6 =882
[xdim ydim]=size(data)
xvals=1:xdim;
xrange = xvals; %linspace(-73,73,xdim);
norm = range(xrange);
meanvals = zeros(xdim);  %% will hold mean value for each of the 10 sets
%% can calc standard deviations etc.. 
plotvals = zeros(xdim);
plotrange = zeros(xdim);
linefit = zeros(4);


    waveno=14;
    meanvals =mean(data,2);
    meanvals =meanvals ; %%- mean(meanvals);
    %Z = [ ones(size(xrange(:))),  sin(2*pi*xrange(:)) ];
    Z = [ ones(size(xrange(:))), xrange(:), sin(waveno*2*pi*xrange(:)/norm), cos(waveno*2*pi*xrange(:)/norm)];

    Y = meanvals;
    linefit = (Z' * Z ) \ (Z' * Y);
    
    error = sqrt( sum((Y - Z*linefit).^2)/length(Y) ); 
    disp(error);
    figure(1)
    plot(xrange,Y,xrange,Z*linefit)
    axis tight
    % xlim([-73,73])
    plotname=namelist(1);
    title(plotname,'FontSize',14)
    xlabel('x','FontSize',12)
    ylabel('Value','FontSize',12)
    l1 = sprintf('%2.1f + %2.1f *x  + %2.1f sin (2 pi(%d) x) + %2.1f cos(2 pi(%d) x)', linefit(1),linefit(2),linefit(3),waveno,linefit(4),waveno);
    legend('Data', l1);
    
    
    figure(2)
    error = sqrt( sum((Y - Z*linefit).^2)/length(Y) ); 
    plot(xrange,((Y - Z*linefit).^2)/length(Y))
    Etit = sprintf("Error %f", error);
    title(Etit)

    
    



