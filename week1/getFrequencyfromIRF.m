function [P,Q]=getFrequencyfromIRF(g,Ts,w)
t=0:Ts:(size(g,2)-1)*Ts;

delta_g=g(2:end)-g(1:(end-1));
t1=t(1:(end-1));
t2=t(2:end);
P=zeros(size(w));
Q=zeros(size(w));
for i=1:size(w,2)
    P(i)=1/w(i)/w(i)*(sum(delta_g/Ts.*(cos(w(i)*t2)-cos(w(i)*t1))));
    Q(i)=-1/w(i)*(g(1)+1/w(i)/Ts*(sum(delta_g.*(sin(w(i)*t2)-sin(w(i)*t1)))));
end