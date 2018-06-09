function [th,x]=order3RungeKuttaMethod(f,x0,u,t,h)
t0=t(1);
td=t(2);
n=fix((td-t0)/h+1);
x=zeros(size(x0,1),n);
th=zeros(1,n);
x(:,1)=x0;
th(1,1)=t0;
for i=2:n
    th(1,i)=th(1,i-1)+h;
    k1=feval(f,x(:,i-1),u,th(1,i-1));
    k2=feval(f,x(:,i-1)+h*k1/3,u,th(1,i-1)+h/3);
    k3=feval(f,x(:,i-1)+2*h*k2/3,u,th(1,i-1)+2*h/3);
    x(:,i)=x(:,i-1)+h/4*(k1+3*k3);
end
if th(1,n)<td
    tmph=td-th(1,n);
    th=[th td];
    k1=feval(f,x(:,n),u,th(1,n));
    k2=feval(f,x(:,n)+tmph*k1/3,u,th(1,n)+tmph/3);
    k3=feval(f,x(:,n)+2*tmph*k2/3,u,th(1,n)+2*tmph/3);
    xd=x(:,n)+tmph/4*(k1+3*k3);
    x=[x xd];
end