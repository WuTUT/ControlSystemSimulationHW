function diffx=rigid(t,x)
diffx=zeros(3,1);
diffx(1)=x(2);
diffx(2)=x(3)+24;
diffx(3)=-24*x(1)-26*x(2)-9*x(3)-192;