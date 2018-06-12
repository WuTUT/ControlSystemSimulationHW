clear

uitest=[-5:0.1:5 4.9:-0.1:-1 -0.9:0.1:1 0.9:-0.1:-5 -4.9:0.1:1 0.9:-0.1:-1 -0.9:0.1:1];
%link = {'zhihuan',2,[],3};
%link = {'siqu',3,[],2};
%link = {'fenduan',3,1,.5};
link = {'siquzhihuan',3,1,3};

%uitest=[-5:0.1:5 4.9:-0.1:-3 -2.9:0.1:2];
%uolast(1,1)=-4;%move uolast(1,1)=-4 down
%link = {'jianxie',2,[],[]};





uotest=zeros(size(uitest));
global uolast;
uolast=zeros(1,1);
global uilast;
uilast=zeros(1,1);

for i=1:size(uitest,2)
    uotest(i)=nonlinearlink(uitest(i),link);
end
figure(1)
plot(uitest,uotest);
grid on
figure(2)
t=1:size(uitest,2);
plot(t,uitest')
hold on
plot(t,uotest')
grid on