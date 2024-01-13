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
% Tilt=inter.Tilt;
% Shift=inter.Shift;
% Slide=inter.Slide;
% Rise=inter.Rise;
% Twist=inter.Twist;

%% reorganize all the data into a single set that we'll manipulate
data=vertcat(inter.Tilt,inter.Roll,inter.Twist,inter.Shift,inter.Slide,inter.Rise);
namelist={'Tilt','Roll','Twist','Shift','Slide','Rise'};

%% set up some info for plotting etc.
%% there are 6 sets of data eaqch 100,000 by 147 in size
%%   we regroup into 10 sets of 147*6 =882 
xvals=-73:1:73;
avgvals = zeros(147,6);  %% will hold mean value for each of the 10 sets
stdval  = zeros(6);
maxval  = zeros(6);
minval  = zeros(6);

mintime = 10000
skip    = 1000
maxtime = 50000
    

for i = 1:6
    figure(1)
    subplot(2,3,i)
  
    surf(data((i-1)*147+1:i*147,mintime:skip:maxtime));
    axis tight
    plotname=namelist(i);
    title(plotname,'FontSize',14)
    xlabel('x','FontSize',12)
    ylabel('Value','FontSize',12)
end

