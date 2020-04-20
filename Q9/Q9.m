function y=Q9(ebno) 
    nsymbols=6000;
     m = 4; %m is the oversampling factor
        %parameters for sampled raised cosine pulse
    a = 0.5;
    length = 10;% (truncated outside [-length*T,length*T])
    %raised cosine transmit filter (time vector set to a dummy variable which is not used)
    temp1=zeros(1,nsymbols);
    temp2=zeros(1,nsymbols); 
    for i=1:nsymbols 
        temp1(i)=randbit();
        temp2(i)=randbit();
    end 
    symbols1=fourpammap(temp1,temp2);
    original=symbols1;
    %FOUR-PAM SYMBOL GENERATION-ORIGINAL SIGNAL UPSAMPLED 
    nsymbols_upsampled1 = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
    symbols_upsampled1 = zeros(nsymbols_upsampled1,1);%initialize
    symbols_upsampled1(1:m:nsymbols_upsampled1)=symbols1;%insert symbols with spacing m

    transmit_filter = rcosdesign(a,nsymbols_upsampled1,m,'sqrt');   %Generating square root raised cosine pulse

    %PASSING ORIGINAL SIGNAL  THROUGH THE  TRANSMITTER FILTER
    tx_output=conv(symbols_upsampled1,transmit_filter);
    %calculation of sigma 
    sigma=sqrt((5/(4*ebno)));
    
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
 for i=1:nsymbols 
    if(real(reciever_out(i))>=2 ) 
        reciever_out(i)=3;
    elseif(real(reciever_out(i))<2 && real(reciever_out(i)) >=0 ) 
        reciever_out(i)=1;
    elseif((real(reciever_out(i))<0 && real(reciever_out(i)) >= -2 )) 
        reciever_out(i)=-1;
    else 
        reciever_out(i)=-3;
    end 
end
original=symbols1;
check1=reciever_out-original;
val1=nnz(check1);
ans1=val1/nsymbols;
fprintf('error percentage after reciver_filter %d \n',ans1);
 
    
    



end