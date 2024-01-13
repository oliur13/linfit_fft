%This code reads the hdf5 file, parses the data,
% and makes some plots

%clean everything before start
clear all
close all
clc

%%% this is the name of hte hd5file assigned to you
hd5fp = '../../../Data/pos10.hd5'
%%%%

%load the file
h5disp(hd5fp) %diplay hdf5 file to see what's inside
inter=h5read(hd5fp,'/inter'); %read inter helical parameters
%intra=h5read('pos11.hd5','/intra'); %read intra helical parameters
%%   there's more here than we'll use to ignore the rest.

%% assign 
% Roll=inter.Roll;
% Tilt=inter.Tilt;
% Shift=inter.Shift;
% Slide=inter.Slide;
% Rise=inter.Rise;
% Twist=inter.Twist;

%% reorganize all the data into a single set that we'll manipulate
data=vertcat(inter.Roll);
namelist={ 'Roll'};

%% set up some info for plotting etc.
%% there are 6 sets of data eaqch 100,000 by 147 in size
%%   we regroup into 10 sets of 147*6 =882 
xvals=1:147;
xrange = linspace(-73,73,147);
meanvals = zeros(147);  %% will hold mean value for each of the 10 sets
%% can calc standard deviations etc.. 
plotvals = zeros(147);
plotrange = zeros(147);
linefit = zeros(2);


    
    meanvals =mean(data,2);
    %Z = [ ones(size(xrange(:))),  sin(2*pi*xrange(:));  ];
    Z = [ ones(size(xrange(:))),  cos(2*pi*xrange(:)*13/147), sin(2*pi*xrange(:)*13/147 )];

    Y = meanvals;
    linefit = (Z' * Z ) \ (Z' * Y);
    
    figure(1)
    plot(xrange,Y,xrange,Z*linefit)
    axis tight
    xlim([-73,73])
    plotname=namelist(1);
    title(plotname,'FontSize',14)
    xlabel('x','FontSize',12)
    ylabel('Value','FontSize',12)
    
    


