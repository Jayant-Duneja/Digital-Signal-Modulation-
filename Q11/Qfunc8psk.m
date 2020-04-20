function y= Qfunc8psk() 
ebnodB=0:0.01:10;
ebno = 10.^(ebnodB/10); 
y = qfunc(sqrt((0.876*ebno)));
plot(ebnodB,log(y)); 
[~ ,idx]=min(abs(y-0.01));
fprintf('value is %d',ebno(idx)); 
%fprintf('value is %d',ebnodB(idx));   
end