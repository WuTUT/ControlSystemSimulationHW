clear
s=tf('s');h=0.01;td=100;
g=[1/(0.4*s+1);10/(2*s+1)];
% g=[1/(10*s+1);1/(20*s+1)];

% sys1=c2d(1/(0.4*s+1),h,'ZOH');
% sys2=c2d(10/(2*s+1),h,'ZOH');
% % sys1=c2d(1/(10*s+1),h,'ZOH');
% % sys2=c2d(1/(20*s+1),h,'ZOH');
% sysd=feedback(sys1*sys2,1);
% figure(1)
% step(sysd,0:0.01:100);

F=[1;0];
P=[0 -1;
   1 0;];
C=[0 1];
tn=fix(td/h)+1;

M=ones(1,tn);
linkn=size(g,1);
link =cell(linkn,4);
link(1,:) = {'zhihuan',0.1,[],1};
link(2,:) = {'none',[],[],[]};
[t,y]=tfsimulation(g,F,M,P,C,h,td,link);
hold on
%plot(t,y,'--r')
plot(t,y)
