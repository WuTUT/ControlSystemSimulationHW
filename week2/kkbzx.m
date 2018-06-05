clear
num=[0 24 24];
den=[1 9 26 24];
m=length(num);
n=length(den)-1;
A=[zeros(n-1,1),eye(n-1)];
A(n,:)=-den(n+1:-1:2)/den(1);
B=zeros(n,1);B(n)=1;
C=zeros(1,n);C(1:m)=num(m:-1:1)/den(1);
y=[1 2 3];%y=[y(0) y'(0) y''(0)...]
u=[0 4 5];%u=[0 u(0), u'(0),...]
Q=zeros(n,n);
Q(1,:)=C(1,:);
for i=2:n
    Q(i,:)=[0 Q(i-1,1:n-1)]+Q(i-1,n)*A(n,:);
end
P=zeros(n,n);
for i=2:n
    for j=2:i
        P(i,j)=Q(i-j+1,n);
    end
end
Y=y'-P*u';
inv(Q)*Y



       
        