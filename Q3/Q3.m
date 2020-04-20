function y=Q3()

m = 4; %m is the oversampling factor
%parameters for sampled raised cosine pulse
a = 0.5;
length = 10;% (truncated outside [-length*T,length*T])
%raised cosine transmit filter (time vector set to a dummy variable which is not used)
transmit_filter = rcosdesign(a,length,m,'sqrt');   %Generating square root raised cosine pulse

%NUMBER OF SYMBOLS
nsymbols = 12000;
temp=zeros(nsymbols,1);
%BPSK SYMBOL GENERATION
for i=1:nsymbols 
    temp(i)=randbit();
end 
symbols=bpskmap(temp);

%UPSAMPLE BY m
nsymbols_upsampled = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
symbols_upsampled = zeros(nsymbols_upsampled,1);%initialize
symbols_upsampled(1:m:nsymbols_upsampled)=symbols;%insert symbols with spacing m

%NOISELESS MODULATED SIGNAL
tx_output = conv(symbols_upsampled,transmit_filter);  
y=conv(tx_output,transmit_filter);  %covolution to get reciever output
% y is the final reciever output

end