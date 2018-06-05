function getmodel(x0,stepsimout,choose_order,sample_time,method)
format long
n=size(stepsimout);
len=n(1);
t=0:sample_time:(n-1)*sample_time;
yinf=stepsimout(len,1)-stepsimout(1,1);
y=stepsimout./yinf;
K=yinf/x0;
t_interp=0:sample_time/1000:(n-1)*sample_time;
y_interp=interp1(t,y,t_interp,method);

if choose_order==1
    sys=order1(t_interp,y_interp,K);
else
    t1=binsearch(y_interp,t_interp,0.4);
    t2=binsearch(y_interp,t_interp,0.8);
    if choose_order==2
        sys=order2(t1,t2,K);
    else
        if choose_order==0
            lamda=t1/t2;
            order=getorder(lamda);
            sys=orderhigh(t1,t2,order,K);
        else
            error('choose_order must be 0 or 1 or 2');
        end
    end
end


figure(1)
step(sys*x0,t)
hold on

plot(t,stepsimout,'--r')
%error=sum(stepsimout)-sum(idy)



function order=getorder(lamda)
lamda_table=[0.32 0.46 0.53 0.58 0.62 0.65 0.67];
x=1:7;
if lamda<=lamda_table(1)
    order=1;
else
    if lamda>lamda_table(7)
        order=7;
    else
        order=round(interp1(lamda_table,x,lamda,'linear'));
    end
end
disp(['order=',num2str(order)]);

function sys=order1(t_interp,y_interp,K)
t1=binsearch(y_interp,t_interp,1-exp(-0.5));
t2=binsearch(y_interp,t_interp,1-exp(-1));
T=2*(t2-t1);
tao=2*t1-t2;
sys=tf(K,[T 1],'inputdelay',tao)
function sys=order2(t1,t2,K)
syms T1 T2
[sT1,sT2]=solve([T1+T2==(t1+t2)/2.16,T1*T2/(T1+T2).^2==1.74*t1/t2-0.55],[T1 T2]);
sT1=eval(sT1(1));
sT2=eval(sT2(1));
sys=tf(K,[sT1*sT2 sT1+sT2 1])
function sys=orderhigh(t1,t2,order,K)
T=(t1+t2)/order/2.16;
disp(['T=',num2str(T)]);
syms s
fden=eval(fliplr(coeffs((T*s+1).^order,s)));
sys=tf(K,fden)
function obj_t=binsearch(y_interp,t_interp,obj_y)
n=size(y_interp);
min=1;max=n(2);
i=floor((min+max)/2);
while abs(obj_y-y_interp(i))>=1e-4
    if obj_y-y_interp(i)>0
        min=i;
        i=floor((min+max)/2);
    else
        max=i;
        i=floor((min+max)/2);
    end
end
obj_t=t_interp(1,i);

    




