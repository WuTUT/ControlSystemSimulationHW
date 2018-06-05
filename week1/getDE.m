function a=getDE(x0,stepsimout,sample_time,maxerror)
n=size(stepsimout);
len=n(1);
bestorder=1;
yinf=stepsimout(len,1);
a(1)=x0/yinf;
S(1)=1;
u=zeros(1,len);
t=0:sample_time:(len-1)*sample_time;
u(1,:)=x0;
while true
    bestorder=bestorder+1;
    tmp1=0;
    for i=1:bestorder-1
        tmp1=tmp1+(-1).^(bestorder-1+i)*a(i)/a(1)*t.^(bestorder-1-i)/ factorial(bestorder-1-i);
    end
    tmpa=a(1)/yinf*trapz(t,(yinf-stepsimout)'.*tmp1);
    if(tmpa/max(a)<=maxerror)
        break;
    end
    a(bestorder)=tmpa;
end
a=fliplr(a);
