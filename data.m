function b= data(x)
%% TcB was here 1/20/23
Ramp =0;
npts =length(x)
b = sin( x(:) )+ Ramp*rand(npts,1) ;
%b = 3*x(:).^2 + 2*x(:) + 5;
% readhdf(....)
return 