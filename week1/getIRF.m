function g=getIRF(u1,y1,a,Ts,L)
format long
u=u1((L+1):end);
NL=size(u,1)/L;
y=y1((L+1):end);
Ruy=zeros(1,L);
g=zeros(1,L);
for k=1:NL
    for i=1:L
        M=0;
        for j=(k-1)*L+1:L*k
            l=i+j-1;
            if l>L
                l=l-L;
            end
            M=M+u(j)*y(l);
        end
        Ruy(i)=Ruy(i)+M/L;
    end
end
Ruy=Ruy./NL;    
W=sum(Ruy);
%t=1:L;plot(t,Ruy)
for i=1:L
    g(i)=L/(1+L)/a/a/Ts*(Ruy(i)+W);
end

        
     
            