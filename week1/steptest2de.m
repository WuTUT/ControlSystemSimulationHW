%get differential equation from step test data
sample_time=0.2;x0=2;maxerror=1e-2;
a=getDE(x0,stepsimout,sample_time,maxerror)
% a=getDE(x0,stepsimout1,sample_time,maxerror)
sys=tf(1,a)

n=size(stepsimout);
len=n(1);
t=0:sample_time:(len-1)*sample_time;
step(sys*x0,t)
hold on;
plot(t,stepsimout,'--r')
% plot(t,stepsimout1,'--r')