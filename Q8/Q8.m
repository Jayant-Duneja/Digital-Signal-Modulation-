function y=Q8()                      %I will only be calculating the value of ideal value
                                      %of eb/no in this code and will create the random
                                      %signal in the next Question onl 
ebnodB=0:0.01:10;
ebno = 10.^(ebnodB/10); 
y = qfunc(sqrt(4*ebno/5));
plot(ebnodB,log(y)); 
[~ ,idx]=min(abs(y-0.01));
fprintf('value is %d',ebno(idx)); 
%fprintf('value is %d',ebnodB(idx)); 
    
                
    
end