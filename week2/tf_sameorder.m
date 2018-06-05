function [A,B,C,D,x0]=tf_sameorder(num,den,y0,u0)

n=size(den,2)-1;
c=num;
a=den(2:end);
%B: beta(1:n)
%Bt:also include beta(0)
Bt=zeros(1,n+1);
Bt(1,1)=c(1);
for i=2:n+1
    Bt(1,i)=c(1,i)-sum(a(1,1:i-1).*Bt(1,i-1:-1:1));
end
B=Bt(1,2:end)';

a11=zeros(n-1,1);
a12=eye(n-1,n-1);
A=[[a11 a12];fliplr(-den(2:end));];

C=[1 zeros(1,n-1)];

D=Bt(1,1);

x0=size(1,n);

for i=1:n
    x0(1,i)=y0(1,i)-sum(Bt(1,1:i).*u0(1,i:-1:1));
end