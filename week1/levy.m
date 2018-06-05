function [a,b,isfound]=levy(w,P,Q,sigma,maxIteration,ordern,orderm)
switch nargin
    case 7
        %the order and the zero point is known
        %for example 5/s^2+s+25,'ordern' is 2,'orderm' is 1
        %so the type of model is certain
        [a,b,isfound]=levy_orderknown(w,P,Q,sigma,maxIteration,ordern,orderm);
    case 5
        %the order and the zero point is unknown
        %ordern and orderm should not be input
        %we try ordern from 2 to 10(most) and m is set to n-1
        %otherwise combinations of m&n are too many
        %we think the order should be as as few as possible,so just break
        %the loop when the error is less than sigma
        tmperror=+inf;tmpbestorder=0;
        for tmporder=2:10
            [a,b,isfound,minerror]=levy_orderunknown(w,P,Q,sigma,maxIteration,tmporder);
            if isfound==true
                break
            else
                if minerror<=tmperror
                    tmperror=minerror;
                    tmpbestorder=tmporder;
                end
            end
        end
        if isfound==false
            [a,b,isfound,~]=levy_orderunknown(w,P,Q,sigma,maxIteration,tmpbestorder);
        end
            
            
    otherwise
        error('wrong paremeters input');
end
function [a,b,isfound,minerror]=levy_orderunknown(w,P,Q,sigma,maxIteration,tmporder)
V=zeros(1,tmporder);
S=zeros(1,tmporder);
T=zeros(1,tmporder);
U=zeros(1,tmporder);
wi1=ones(size(w));
wi2=zeros(size(w));
D=zeros(size(w));
iteration=1;isfound=false;
while iteration<=maxIteration
    for i=1:tmporder
        we=w.^((i-1)*2);
        wo=w.^(i*2-1);
        V(i)=sum(we.*wi1);
        S(i)=sum(we.*P.*wi1);
        T(i)=sum(wo.*Q.*wi1);
        U(i)=sum(wo.*w.*(P.*P+Q.*Q).*wi1);
    end
    a11=zeros(tmporder,tmporder);
    a12=zeros(tmporder,tmporder);
    a21=zeros(tmporder,tmporder);
    a22=zeros(tmporder,tmporder);
    b11=zeros(tmporder,1);
    b21=zeros(tmporder,1);
    for i=1:2:tmporder
        for j=1:2:tmporder
            if mod((j-1)/2,2)==0
                a11(i,j)=V((i+j)/2);
                a22(i,j)=U((i+j)/2);
                a12(i,j)=T((i+j)/2);
                a21(i,j)=T((i+j)/2);
            else
                a11(i,j)=-V((i+j)/2);
                a22(i,j)=-U((i+j)/2);
                a12(i,j)=-T((i+j)/2);
                a21(i,j)=-T((i+j)/2);
            end
        end
    end
    for i=2:2:tmporder
        for j=2:2:tmporder
            if mod(j/2,2)==1
                a11(i,j)=V((i+j)/2);
                a22(i,j)=U((i+j)/2);
                a12(i,j)=T((i+j)/2);
                a21(i,j)=T((i+j)/2);
            else
                a11(i,j)=-V((i+j)/2);
                a22(i,j)=-U((i+j)/2);
                a12(i,j)=-T((i+j)/2);
                a21(i,j)=-T((i+j)/2);
            end
        end
    end
    for i=1:2:tmporder
        for j=2:2:tmporder
            if mod(j/2,2)==1
                a12(i,j)=S((i+j+1)/2);
                a21(i,j)=-S((i+j+1)/2);
            else
                a12(i,j)=-S((i+j+1)/2);
                a21(i,j)=S((i+j+1)/2);
            end
        end
    end
    for i=2:2:tmporder
        for j=1:2:tmporder
            if mod((j-1)/2,2)==1
                a12(i,j)=S((i+j+1)/2);
                a21(i,j)=-S((i+j+1)/2);
            else
                a12(i,j)=-S((i+j+1)/2);
                a21(i,j)=S((i+j+1)/2);
            end
        end
    end
    for i=1:2:tmporder
        b11(i,1)=S((i-1)/2+1);
    end
    for i=2:2:tmporder
        b11(i,1)=T(i/2);
        b21(i,1)=U(i/2);
    end
    A=[a11 a12;
        a21 a22;];
    B=[b11;
        b21;];
%     Xab=inv(A)*B;
    Xab=A\B;
    b=Xab(1:tmporder);
    a=Xab(tmporder+1:2*tmporder);
    for i=1:size(w,2)
        for k=1:tmporder
        D(i)=D(i)+a(k)*(((0+1j)*w(i)).^k);
        end
    end
    wi2=1./(abs(D).*abs(D));
    if mean(abs(1-wi2./wi1))<=sigma
        isfound=true;
        minerror=-1;
        break
    else
        minerror=mean(abs(1-wi2./wi1));
        wi1=wi2;
        iteration=iteration+1;
    end
end



function [a,b,isfound]=levy_orderknown(w,P,Q,sigma,maxIteration,ordern,orderm)
V=zeros(1,orderm);
S=zeros(1,ordern);
T=zeros(1,ordern);
U=zeros(1,ordern);
wi1=ones(size(w));
wi2=zeros(size(w));
D=zeros(size(w));
iteration=1;isfound=false;
while iteration<=maxIteration
    for i=1:ordern 
        wo=w.^(i*2-1);
        we=w.^((i-1)*2);   
        T(i)=sum(wo.*Q.*wi1);
        U(i)=sum(wo.*w.*(P.*P+Q.*Q).*wi1);
        S(i)=sum(we.*P.*wi1);
    end
    for i=1:orderm
        we=w.^((i-1)*2);
        V(i)=sum(we.*wi1);
        
    end
    a11=zeros(orderm,orderm);
    a12=zeros(orderm,ordern);
    a21=zeros(ordern,orderm);
    a22=zeros(ordern,ordern);
    b11=zeros(orderm,1);
    b21=zeros(ordern,1);
    for i=1:2:orderm
        for j=1:2:orderm
            if mod((j-1)/2,2)==0
                a11(i,j)=V((i+j)/2);    
            else
                a11(i,j)=-V((i+j)/2);
            end
        end
    end
    for i=2:2:orderm
        for j=2:2:orderm
            if mod(j/2,2)==1
                a11(i,j)=V((i+j)/2);
            else
                a11(i,j)=-V((i+j)/2);

            end
        end
    end
    for i=1:2:ordern
        for j=1:2:ordern
            if mod((j-1)/2,2)==0               
                a22(i,j)=U((i+j)/2);
            else                
                a22(i,j)=-U((i+j)/2);             
            end
        end
    end
    for i=2:2:ordern
        for j=2:2:ordern
            if mod(j/2,2)==1  
                a22(i,j)=U((i+j)/2);
            else
                
                a22(i,j)=-U((i+j)/2);

            end
        end
    end
    for i=1:2:orderm
        for j=1:2:ordern
            if mod((j-1)/2,2)==0            
                a12(i,j)=T((i+j)/2);
            else               
                a12(i,j)=-T((i+j)/2);               
            end
        end
    end
    for i=2:2:orderm
        for j=2:2:ordern
            if mod(j/2,2)==1
                
                a12(i,j)=T((i+j)/2);
                
            else
                
                a12(i,j)=-T((i+j)/2);
                
            end
        end
    end
    for i=1:2:ordern
        for j=1:2:orderm
            if mod((j-1)/2,2)==0
                
                a21(i,j)=T((i+j)/2);
            else
               
                a21(i,j)=-T((i+j)/2);
            end
        end
    end
    for i=2:2:ordern
        for j=2:2:orderm
            if mod(j/2,2)==1
               
                a21(i,j)=T((i+j)/2);
            else
                
                a21(i,j)=-T((i+j)/2);
            end
        end
    end
    for i=1:2:ordern
        for j=2:2:orderm
            if mod(j/2,2)==1
                
                a21(i,j)=-S((i+j+1)/2);
            else
                
                a21(i,j)=S((i+j+1)/2);
            end
        end
    end
    for i=2:2:ordern
        for j=1:2:orderm
            if mod((j-1)/2,2)==1
                
                a21(i,j)=-S((i+j+1)/2);
            else
                
                a21(i,j)=S((i+j+1)/2);
            end
        end
    end
    for i=1:2:orderm
        for j=2:2:ordern
            if mod(j/2,2)==1
                a12(i,j)=S((i+j+1)/2);
                
            else
                a12(i,j)=-S((i+j+1)/2);
                
            end
        end
    end
    for i=2:2:orderm
        for j=1:2:ordern
            if mod((j-1)/2,2)==1
                a12(i,j)=S((i+j+1)/2);
                
            else
                a12(i,j)=-S((i+j+1)/2);
                
            end
        end
    end
    for i=1:2:orderm
        b11(i,1)=S((i-1)/2+1);
    end
    for i=2:2:orderm
        b11(i,1)=T(i/2);
    end
    for i=2:2:ordern
        b21(i,1)=U(i/2);
    end
%     size(a11)
%     size(a12)
%     size(a21)
%     size(a22)
    A=[a11 a12;
        a21 a22;];
    B=[b11;
        b21;];
    Xab=A\B;
    b=Xab(1:orderm);
    a=Xab(orderm+1:orderm+ordern);
    for i=1:size(w,2)
        for k=1:ordern
        D(i)=D(i)+a(k)*(((0+1j)*w(i)).^k);
        end
    end
    wi2=1./(abs(D).*abs(D));
    if mean(abs(1-wi2./wi1))<=sigma
        isfound=true;
        break
    else
        wi1=wi2;
        iteration=iteration+1;
    end
end