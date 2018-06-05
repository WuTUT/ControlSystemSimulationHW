sys=idtf(5,[1 1 25]);
u0=1;L=255;Ts=0.1;
%  sys=idtf(3.5,[1 2 1]);
%  u0=1;L=255;Ts=0.1;
% sys=idtf(1.2,[8.3*6.2 8.3+6.2 1]);
% u0=1;L=127;Ts=1;
u=idinput([L 1 8],'prbs',[],[-u0 u0]);
u1=iddata([],u,Ts);
y1=sim(sys,u1);
%add white noise disturbance
yout=awgn(y1.OutputData,50,'measured');
%without disturbance
%yout=y1.OutputData;
t=0:Ts:(L-1)*Ts;
y_theoretical=impulse(sys,t);
%get Impulse Response Function
g=getIRF(u1.InputData,yout,u0,Ts,L);
%plot identified IRF: g and true IRF: y_theoretical
figure(1)
plot(t,g)
hold on
plot(t,y_theoretical,'r')

%I want to use these to find some imformation about the source of error 
error=sum(abs(g-y_theoretical'))/L
errormax=max(abs(g-y_theoretical'))
figure(2)
%the error between identified g(t) and true g(t)

plot(t,(g-y_theoretical'))
