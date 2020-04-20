function y=Q11(ebno) 
   nsymbols=4000;
     m = 4; %m is the oversampling factor
        %parameters for sampled raised cosine pulse
    a = 0.5;
    length = 10;% (truncated outside [-length*T,length*T])
    %raised cosine transmit filter (time vector set to a dummy variable which is not used)
    temp1=zeros(1,nsymbols);
    temp2=zeros(1,nsymbols); 
    temp3=zeros(1,nsymbols); 
    
    for i=1:nsymbols 
        temp1(i)=randbit();
        temp2(i)=randbit(); 
        temp3(i)=randbit();
       
    end 
    symbols1=EightpskMappping(temp1,temp2,temp3);
    original=symbols1;
    %FOUR-PAM SYMBOL GENERATION-ORIGINAL SIGNAL UPSAMPLED 
    nsymbols_upsampled1 = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
    symbols_upsampled1 = zeros(nsymbols_upsampled1,1);%initialize
    symbols_upsampled1(1:m:nsymbols_upsampled1)=symbols1;%insert symbols with spacing m

    transmit_filter = rcosdesign(a,nsymbols_upsampled1,m,'sqrt');   %Generating square root raised cosine pulse

    %PASSING ORIGINAL SIGNAL  THROUGH THE  TRANSMITTER FILTER
    tx_output=conv(symbols_upsampled1,transmit_filter);
    %calculation of sigma 
    sigma=sqrt((1/(6*ebno)));
    
    %Gaussian noise generation 
    symbols= normrnd(0,sigma,size(tx_output)) + 1i*normrnd(0,sigma,size(tx_output));
    temp1=symbols + tx_output;
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
 distance=zeros(1,8);
 for i=1:nsymbols 
    distance(1)=reciever_out(i)-exp(0*1i*pi/4); 
    distance(2)=reciever_out(i)-exp(1*1i*pi/4);
    distance(3)=reciever_out(i)-exp(3*1i*pi/4); 
    distance(4)=reciever_out(i)-exp(2*1i*pi/4); 
    distance(5)=reciever_out(i)-exp(7*1i*pi/4); 
    distance(6)=reciever_out(i)-exp(6*1i*pi/4);
    distance(7)=reciever_out(i)-exp(4*1i*pi/4); 
    distance(8)=reciever_out(i)-exp(5*1i*pi/4);
    distance=abs(distance);
     [~,idx]=min(distance);
     if(idx==1) 
        reciever_out(i)= exp(0*1i*pi/4);
     elseif(idx==2) 
        reciever_out(i)= exp(1*1i*pi/4);
     elseif(idx==3) 
        reciever_out(i)= exp(3*1i*pi/4); 
     elseif(idx==4) 
        reciever_out(i)= exp(2*1i*pi/4); 
     elseif(idx==5) 
        reciever_out(i)= exp(7*1i*pi/4); 
     elseif(idx==6) 
        reciever_out(i)= exp(6*1i*pi/4); 
     elseif(idx==7) 
        reciever_out(i)=exp(4*1i*pi/4); 
     elseif(idx==8) 
        reciever_out(i)= exp(5*1i*pi/4); 
     end
  
end
original=symbols1;
check1=reciever_out-original;
val1=nnz(check1);
ans1=val1/nsymbols;
fprintf('error percentage after reciver_filter %d \n',ans1);
    
end  
