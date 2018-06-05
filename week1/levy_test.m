
% clear
% w=0.04:0.04:40;
% sys=tf(5,[1 1 25]);
% [re,im]=nyquist(sys,w);
% 
% k=size(w,2);
% P=zeros(1,k);
% Q=zeros(1,k);
% P(1,1:k)=re(1,1,:);
% Q(1,1:k)=im(1,1,:);

sigma=0.002;
maxIteration=1000;

[a,b,isfound]=levy(w,P,Q,sigma,maxIteration,2,1);
% [a,b,isfound]=levy(w,P,Q,sigma,maxIteration);
num=fliplr(b');
den=[fliplr(a') 1];
sys1=tf(num,den)
isfound
figure(1);
% plot(P,Q,'rx');
plot(x,y,'rx');
hold on
nyquist(sys1);
legend('Real Model Result Plot','Simulate Model Nyquist Curve');