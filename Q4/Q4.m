function [y,nsymbols_upsampled1,temp1,symbols1]= Q4(sigma)     %temp1 is the signal before the reciever.nsymbols_upsampled will be used in question 6
 m = 4; %m is the oversampling factor
%parameters for sampled raised cosine pulse
a = 0.5;
length = 10;% (truncated outside [-length*T,length*T])
%raised cosine transmit filter (time vector set to a dummy variable which is not used)


%NUMBER OF SYMBOLS
nsymbols = 12000;

%BPSK SYMBOL GENERATION.  
%ORIGINAL SYMBOLS GENERATED

temp=zeros(1,nsymbols);
for i=1:nsymbols 
    temp(i)=randbit();
end 
symbols1=bpskmap(temp); %SYMBOLS1 IS USED FOR ALL THE COMPUTATION OF THE SIGNAL AND SYMBOLS IS USED FOR THE NOISE COMPUTATION


%BPSK SYMBOL GENERATION-ORIGINAL SIGNAL UPSAMPLED 
nsymbols_upsampled1 = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
symbols_upsampled1 = zeros(nsymbols_upsampled1,1);%initialize
symbols_upsampled1(1:m:nsymbols_upsampled1)=symbols1;%insert symbols with spacing m

transmit_filter = rcosdesign(a,nsymbols_upsampled1,m,'sqrt');   %Generating square root raised cosine pulse

%PASSING ORIGINAL SIGNAL  THROUGH THE  TRANSMITTER FILTER
tx_output=conv(symbols_upsampled1,transmit_filter);

%Gaussian noise generation 
symbols= normrnd(0,sigma,size(tx_output)) + 1i*normrnd(0,sigma,size(tx_output));


temp1=symbols + tx_output;
y=conv(temp1,transmit_filter); 





end


