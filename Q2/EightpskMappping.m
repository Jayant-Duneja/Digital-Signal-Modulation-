function y=EightpskMappping(x,w,z) 
    t=length(x);
    y=zeros(1,t);
    for i=1:t 
        if(x(i)==0 && w(i)==0 && z(i)==0) 
            y(i)=1; 
        elseif(x(i)==0 && w(i)==0 && z(i)==1) 
            y(i)=exp(1i*pi/4);
        elseif(x(i)==0 && w(i)==1 && z(i)==0) 
            y(i)=exp(3*1i*pi/4); 
        elseif(x(i)==0 && w(i)==1 && z(i)==1) 
            y(i)=exp(2*1i*pi/4);
        elseif(x(i)==1 && w(i)==0 && z(i)==0) 
            y(i)=exp(7*1i*pi/4);
        elseif(x(i)==1 && w(i)==0 && z(i)==1) 
            y(i)=exp(6*1i*pi/4); 
        elseif(x(i)==1 && w(i)==1 && z(i)==0) 
            y(i)=exp(4*1i*pi/4);
        elseif(x(i)==1 && w(i)==1 && z(i)==1) 
            y(i)=exp(5*1i*pi/4);
        end
            
    
    end
    
    
end