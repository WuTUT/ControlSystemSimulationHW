clear
% input 
num=[0 24 24];
den=[1 9 26 24];
y0=[1 0.5 0]';
u0=[1 -0.5 0]';

n=size(den,2)-1;
%create matrix A,B,C
a11=zeros(1,n-1);
a21=eye(n-1,n-1);
A=[[a11;a21;] fliplr(-den(2:end))']

B=fliplr(num)'

C=[zeros(1,n-1) 1]

%x0:initial value of state(x)
P=zeros(n,n);
tmp=fliplr(den(1:end-1));
for i=1:n
    P(i,1:n-i+1)=tmp(i:end);
end
Q=zeros(n,n);
tmp=-fliplr([0 num(1:end-1)]);
for i=1:n
    Q(i,1:n-i+1)=tmp(i:end);
end
x0=P*y0+Q*u0