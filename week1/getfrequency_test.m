w=0.04:0.04:40;
sys=tf(5,[1 1 25]);

%sample in the book
% sys=tf(3.5,[1 2 1]); 

%use the true IRF to test if 'get P and Q' is right(first,input 'clear' to refresh g(t))  
L=255;Ts=0.1;t=0:Ts:(L-1)*Ts;
g=impulse(sys,t);g=g';figure(8);plot(t,g);hold on
%over

[P,Q]=getFrequencyfromIRF(g,Ts,w);


[re,im]=nyquist(sys,w);

k=size(w,2);
x=zeros(1,k);
y=zeros(1,k);
x(1,1:k)=re(1,1,:);
y(1,1:k)=im(1,1,:);

% figure(1)
% plot(w,x,'--r')
% hold on
% plot(w,P);
% figure(2)
% plot(w,y,'--r')
% hold on
% plot(w,Q);
% fupin=sqrt(P.*P+Q.*Q);
% fupinreal=sqrt(x.*x+y.*y);
% figure(3)
% plot(w,fupin)
% hold on
% plot(w,fupinreal)
% errorfupin=sum(fupin-fupinreal)/k

figure(4)
plot(x,y,'*r');
hold on 
plot(P,Q,'*b');
grid on



error1=sum(abs(x-P))/k
error2=sum(abs(y-Q))/k
% find((x-P)==max(x-P))
