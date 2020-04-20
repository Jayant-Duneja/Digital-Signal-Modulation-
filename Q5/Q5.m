function y=Q5()
    ebnodB=0:0.01:10;
    ebno = 10.^(ebnodB/10); 
    y = qfunc(sqrt(2*ebno));
    plot(ebnodB,log(y)); 
    [~ ,idx]=min(abs(y-0.01));
    fprintf('value is %d in raw',ebno(idx)); 
    %fprintf('value is %d in raw',ebnodB(idx)); 
    
end