function y=Q7(ebno)    %ebno is the value we calculated in Q5

[reciever_out,reciever_in,original]=Q6(ebno);
nsymbols=12000;
for i=1:length(reciever_out) 
    if(real(reciever_out(i)) > 0) 
        reciever_out(i)=1;
    else 
        reciever_out(i)=-1;
    end 
end
check1=reciever_out-original;
val1=nnz(check1);
ans1=val1/nsymbols;
fprintf('error percentage after reciver_filter %d \n',ans1);
 
 
 for i=1:length(reciever_in) 
    if(abs(real(reciever_in(i))-1) >= abs(real(reciever_in(i))+1))  % Mapping the values by using Map rule for Noise
        reciever_in(i)=-1;                               %If both distances are equal,then also we map to 1
    else 
        reciever_in(i)=1; 
    end
 end
 check2=reciever_in-original;
 val2=nnz(check2);
 ans2=val2/nsymbols;
 fprintf('error percentage before reciver_filter %d \n',ans2);
   
  
    
end