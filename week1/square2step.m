n=size(squaresimout);
delta_t=4;sample_time=0.2;
y=zeros(n(1),1);
delta_i=delta_t/sample_time;
for i=1:delta_i
    y(i,1)=squaresimout(i,1);
end
for i=delta_i+1:n(1)
    y(i,1)=squaresimout(i,1)+y(i-delta_i,1);
end

i=1:n(1);
figure(1)
plot(i,y(:,1));
hold on
plot(i,stepsimout,'--r');
error=sum(abs(stepsimout-y))
