function diffx=obj_fun(x,u,t)
A=[0,1,0;
   0,0,1;
   -24,-26,-9;];
B=[0;24;-192;];
diffx=A*x+B*u;