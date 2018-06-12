function [t,y]=tfsimulation(g,F,M,P,C,h,td,link)
tn=fix(td/h)+1;
t=zeros(1,tn);
y=zeros(1,tn);
gd=c2d(g,h,'ZOH');

[num, den]=tfdata(gd,'v');
if iscell(num)
    num=cell2mat(num);
end
if iscell(den)
    den=cell2mat(den);
end
u=zeros(size(num));
x=zeros(size(den,1),size(den,2)-1);
global uolast;
uolast=zeros(size(u));
global uilast;
uilast=zeros(size(u));
x1=zeros(size(x,1),1);
for i=2:tn
    t(i)=t(i-1)+h;
    u1=F*M(:,i)+P*x;
    u(:,1:end-1)=u(:,2:end);
    u(:,end)=nonlinearlink(u1,link);
    y(i)=C*x;
    for j=1:size(x,1)
        x1(j)=-den(j,2:end)*x(j,:)'+num(j,:)*u(j,:)';
    end
    x(:,1:end-1)=x(:,2:end);
    x(:,end)=x1;
end