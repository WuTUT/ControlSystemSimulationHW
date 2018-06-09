clear
A=[0     1     0;
   0     0     1;
  -24   -26   -9;];
B=[0;
    24;
  -192;];
syms T
[f,fm]=StateTransitionMethod(A,B,T,'ZOH')
[f,fm,fm2]=StateTransitionMethod(A,B,T,'TriangleHolder')