function y=qpskmap(x,w) 
    t=length(x);
    y=zeros(1,t);
    for i=1:t 
        if(x(i)==0 && w(i)==0) 
            y(i)=1+1i; 
        elseif(x(i)==0 && w(i)==1) 
            y(i)=-1+1i;
        elseif(x(i)==1 && w(i)==1) 
            y(i)=-1-1i;
        elseif(x(x(i)==1 && w(i)==0))
            y(i)=1-1i;
        end
            
    
    end
    
end