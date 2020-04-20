function y=Q12(ebno) 
nsymbols=3000;
     m = 4; %m is the oversampling factor
        %parameters for sampled raised cosine pulse
    a = 0.5;
    length = 10;% (truncated outside [-length*T,length*T])
    %raised cosine transmit filter (time vector set to a dummy variable which is not used)
    temp1=zeros(1,nsymbols);
    temp2=zeros(1,nsymbols); 
    temp3=zeros(1,nsymbols); 
    temp4=zeros(1,nsymbols);
    for i=1:nsymbols 
        temp1(i)=randbit();
        temp2(i)=randbit(); 
        temp3(i)=randbit();
        temp4(i)=randbit();
    end 
    symbols1=sixteenQamMapping(temp1,temp2,temp3,temp4);
    original=symbols1;
    %FOUR-PAM SYMBOL GENERATION-ORIGINAL SIGNAL UPSAMPLED 
    nsymbols_upsampled1 = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
    symbols_upsampled1 = zeros(nsymbols_upsampled1,1);%initialize
    symbols_upsampled1(1:m:nsymbols_upsampled1)=symbols1;%insert symbols with spacing m

    transmit_filter = rcosdesign(a,nsymbols_upsampled1,m,'sqrt');   %Generating square root raised cosine pulse
    %calculation of sigma 
    sigma=sqrt((15/(16*ebno)));
     
    %Gaussian noise generation 
    symbols= normrnd(0,sigma,size(symbols_upsampled1)) + 1i*normrnd(0,sigma,size(symbols_upsampled1));
    
    symbols_upsampled1=symbols+symbols_upsampled1;
    
    %PASSING ORIGINAL SIGNAL  THROUGH THE  TRANSMITTER FILTER
    tx_output=conv(symbols_upsampled1,transmit_filter);
    
   
    temp1=tx_output;
    y=conv(temp1,transmit_filter); 
 %xxxxxxxxxxxxxxxxx.SYMBOLS AFTER THE RECIEVER HAVE BEEN CREATED.NOW WE
 %NEED TO UPSAMPLE AGAIN TO GET THE DESIRED VALUES AND THEN FOLLOW DECISION
 %RULE 
 a=zeros(1,nsymbols); 
 for i=1:nsymbols 
    a(i)=y(nsymbols_upsampled1*m +1 + (m*(i-1)));  % a(i) are the final samples of the signal after the output filter
 end  
 scatter(real(a),imag(a)); 
 %xxxxxxxxxxxxxxxxxx.SYMBOLS HAVE BEEN UPSAMPLED AGAIN AND ONLY THE NOISY
 %VERSIONS HAVE BEEN OBTAINED.NOW WE JUST NEED TO MAKE APPROPRIATE DECISION
 %RULE. 
 reciever_out=a; 
 distance=zeros(1,16);
 for i=1:nsymbols 
    distance(1)=reciever_out(i)-(-3-3i); 
    distance(2)=reciever_out(i)-(-3-1i);
    distance(3)=reciever_out(i)-(-3+1i);
    distance(4)=reciever_out(i)-(-3+3i); 
   
    distance(5)=reciever_out(i)-(-1+3i); 
    distance(6)=reciever_out(i)-(-1+1i);
    distance(7)=reciever_out(i)-(-1-1i);
    distance(8)=reciever_out(i)-(-1-3i); 
    
    distance(9)=reciever_out(i)-(1-3i); 
    distance(10)=reciever_out(i)-(1-1i);
    distance(11)=reciever_out(i)-(1+1i);
    distance(12)=reciever_out(i)-(1+3i); 
    
    distance(13)=reciever_out(i)-(3+3i); 
    distance(14)=reciever_out(i)-(3+1i);
    distance(15)=reciever_out(i)-(3-1i);
    distance(16)=reciever_out(i)-(3-3i); 
    
    distance=abs(distance);
     [~,idx]=min(distance);
     if(idx==1) 
        reciever_out(i)= -3-3i;
     elseif(idx==2) 
        reciever_out(i)= -3-1i; 
     elseif(idx==3) 
        reciever_out(i)= -3+1i; 
     elseif(idx==4) 
        reciever_out(i)= -3+3i; 
     
     elseif(idx==5) 
        reciever_out(i)= -1+3i; 
     elseif(idx==6) 
        reciever_out(i)= -1+1i; 
     elseif(idx==7) 
        reciever_out(i)= -1-1i; 
     elseif(idx==8) 
        reciever_out(i)= -1-3i; 
     
     elseif(idx==9) 
        reciever_out(i)= 1-3i;
     elseif(idx==10) 
        reciever_out(i)= 1-1i; 
     elseif(idx==11) 
        reciever_out(i)= 1+1i; 
     elseif(idx==12) 
        reciever_out(i)= 1+3i;  
         
     elseif(idx==13) 
        reciever_out(i)= 3+3i; 
     elseif(idx==14) 
        reciever_out(i)= 3+1i; 
     elseif(idx==15) 
        reciever_out(i)= 3-1i; 
     elseif(idx==16) 
        reciever_out(i)= 3-3i; 
     
     
  
     
     
     
     end
  
end
original=symbols1;
check1=reciever_out-original;
val1=nnz(check1);
ans1=val1/nsymbols;
fprintf('error percentage after reciver_filter at initial value %d \n',ans1);  
%fprintf('error percentage after reciver_filter after adding 3dB %d \n',ans1 );

end