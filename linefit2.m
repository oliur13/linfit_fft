npts = 100;
x = linspace(0,2*pi,npts);
b=data(x);
npoly=3;
Z = ones(npts,npoly)
for np = 2:npoly+1
    tmp = x(:).^(np-1)
    %norm = sqrt(dot(tmp,tmp));
    Z(:,np) = tmp;
end
coeffs = (Z'*Z)\(Z'*b)

%coeffs(1:4)=0

plot(x,Z*coeffs,x,b)
legend("approx","data")
