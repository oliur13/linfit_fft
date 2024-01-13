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
namelist={'Roll'};

%% set up some info for plotting etc.
%% there are 6 sets of data eaqch 100,000 by 147 in size
%%   we regroup into 10 sets of 147*6 =882 

xmin=176-147-6;
xmax=xmin+146;
data=data(xmin:xmax,:);
[xdim,ydim]=size(data);
xvals=1:xdim;
% xvals=-73:1:73;
% avgvals = zeros(147,6);  %% will hold mean value for each of the 10 sets
% stdval  = zeros(6);
% maxval  = zeros(6);
% minval  = zeros(6);

mintime = 1;
skip    = 100;
maxtime = 100000;
%% 

surf(data((0)*147+1:147,mintime:skip:maxtime));
axis tight
plotname=namelist(1);
title(plotname,'FontSize',14)
xlabel('x','FontSize',12)
ylabel('Value','FontSize',12)

