clear
num=[0 0 24 24];
den=[1 9 26 24];
y0=[1 0.5 0];
u0=[1 -0.5 0];
[A,B,C,D,x0]=tf_sameorder(num,den,y0,u0)
