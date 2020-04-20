function y=sixteenQamMapping(a,b,c,d) 
    t=length(a);
    y=zeros(1,t);  
    
    for i=1:t  
        if(a(i)==0 && b(i)==0 && c(i)==0 && d(i)==0 ) 
            y(i)=-3-3i;
        elseif(a(i)==0 && b(i)==0 && c(i)==0 && d(i)==1 )
            y(i)=-3-1i; 
        elseif(a(i)==0 && b(i)==0 && c(i)==1 && d(i)==1 )
            y(i)=-3+1i;
        elseif(a(i)==0 && b(i)==0 && c(i)==1 && d(i)==0 )
            y(i)=-3+3i; 
        
        elseif(a(i)==0 && b(i)==1 && c(i)==1 && d(i)==0 )
            y(i)=-1+3i; 
        elseif(a(i)==0 && b(i)==1 && c(i)==1 && d(i)==1 )
            y(i)=-1+1i; 
        elseif(a(i)==0 && b(i)==1 && c(i)==0 && d(i)==1 )
            y(i)=-1-1i;
        elseif(a(i)==0 && b(i)==1 && c(i)==0 && d(i)==0 )
            y(i)=-1-3i;  
        
        elseif(a(i)==1 && b(i)==1 && c(i)==0 && d(i)==0 )
            y(i)=1-3i; 
        elseif(a(i)==1 && b(i)==1 && c(i)==0 && d(i)==1 )
            y(i)=1-1i; 
        elseif(a(i)==1 && b(i)==1 && c(i)==1 && d(i)==1 )
            y(i)=1+1i;
        elseif(a(i)==1 && b(i)==1 && c(i)==1 && d(i)==0 )
            y(i)=1+3i;      
        
        elseif(a(i)==1 && b(i)==0 && c(i)==1 && d(i)==0 )
            y(i)=3+3i; 
        elseif(a(i)==1 && b(i)==0 && c(i)==1 && d(i)==1 )
            y(i)=3+1i; 
        elseif(a(i)==1 && b(i)==0 && c(i)==0 && d(i)==1 )
            y(i)=3-1i;
        elseif(a(i)==1 && b(i)==0 && c(i)==0 && d(i)==0 )
            y(i)=3-3i;      
            
        
        end
    
    end
end