function [th,x]=EulerTrapezoidalMethod(f,x0,u,t,h,error,onestepmaxiteration)
t0=t(1);
td=t(2);
n=fix((td-t0)/h+1);
x=zeros(size(x0,1),n);
th=zeros(1,n);
x(:,1)=x0;
th(1,1)=t0;
diffx1=feval(f,x0,u,t0);
for i=2:n
    th(1,i)=th(1,i-1)+h;
    diffx2=zeros(size(x0));
    x_old=zeros(size(x0));
    it=1;
    while it<onestepmaxiteration
        it=it+1;
        x(:,i)=x(:,i-1)+h/2.*(diffx1+diffx2);
        if abs(x_old-x(:,i))<error
            break;
        else
            x_old=x(:,i);
            diffx2=feval(f,x_old,u,th(1,i));
        end
    end
    if it==onestepmaxiteration
        error('cannot achieve the setting error');
    end
    diffx1=diffx2;
end
if th(1,n)<td
    tmph=td-th(1,n);
    th=[th td];
    x_old=zeros(size(x0));
    diffx2=zeros(size(x0));
    it=1;
    while it<onestepmaxiteration
        it=it+1;
        xd=x(:,n)+tmph/2.*(diffx1+diffx2);
        if abs(x_old-xd)<error
            break;
        else
            x_old=xd;
            diffx2=feval(f,x_old,u,td);
        end
    end
    if it==onestepmaxiteration
        error('cannot achieve the setting error');
    end
    x=[x xd];
end
    
    
    
    
    