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
cumvals = zeros(147,6);
stdval  = zeros(6);
maxval  = zeros(6);
minval  = zeros(6);


mintime = 10000
maxtime = 50000
    
    data2=data(:,mintime:maxtime);
    avgvals=reshape(mean(data2,2),147,6);
    

for i = 2:2
    figure(1)
    subplot(1,1,1)
  
    nostds = 2;
   
    stdval(i) = std(avgvals(:,i));
    maxval(i) = max(avgvals(:,i));
    minval(i) = min(avgvals(:,i));
    cumvals(:,i) = cumsum(avgvals(:,i));
    
    fftdat = fft(avgvals(:,i));
    L = length(avgvals(:,i));
    fftfilter = zeros(L,1);
    wavenums = [ 15]
    
    for k = 1:length(wavenums)
        fftfilter(wavenums(k)) = 1 ;
        fftfilter(end-wavenums(k)+2) = 1 ;
    end

%     totspec = sum(abs(fftdat(2:end)));
%     for k = 2: ceil(L/2)
%         if (abs(fftdat(k))/totspec > 0.01 )
%             fftfilter(k) = 1;
%             fftfilter(end+2-k) = 1;
%         end
%     end
    fftfilter(1) = 1;
    nfftdat = fftfilter .* fftdat;
%     nfftdat = fftdat;
%     spec2 = abs(fftdat/L);
%     spec1 = spec2(1:L/2+1);
%     spec1(2:end-1) = 2*spec1(2:end-1);
    
%     totspec = fftdat/sum(abs(fftdat));
%     tol = 0.01;
%     for k =2:L
%         if(abs(totspec(k)) < tol) 
%             fftdat(k) = 0 ; 
%         end
%     end
    
    plot( -73:1:73,real(ifft(nfftdat)),-73:1:73,avgvals(:,i));
    %plot( abs(nfftdat)/(L/2));
    plotname=namelist(i);
    title(plotname,'FontSize',14)
    xlabel('x','FontSize',12)
    ylabel('Value','FontSize',12)
    
    error =sum((real(ifft(nfftdat)) - avgvals(:,i)).^2) ;
    error = sqrt(error/length(avgvals(:,i)));
    Etit = sprintf("Error %f", error);
    title(Etit)

end

