u=1;
error=4e-4;
onestepmaxiteration=3000;
t=[0,1];
h=0.02;
C=[1,0,0];x0=[1.0000    0.5000  -24.0000];
[th,x]=EulerTrapezoidalMethod('obj_fun',x0',u,t,h,error,onestepmaxiteration);
options=odeset('AbsTol',[4e-4 4e-4 4e-4]);
[T,X]=ode45(@rigid,[0 1],x0,options);
figure(1)
plot(T,X(:,1),'-',T,X(:,2),'-.',T,X(:,3),'--');
hold on
plot(th,x(1,:),'*',th,x(2,:),'*',th,x(3,:),'*');
figure(2)
Y_ode45=C*X';
Y_ETM=C*x;
plot(T,Y_ode45,'-');
hold on
plot(th,Y_ETM,'*');