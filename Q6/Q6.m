function [a,b,original]=Q6(ebno)      %We will use a value of 2.7 for ebno because that was calculated from the equation in Question 4
 [out,nsym_up,in,original]=Q4(sqrt(1/(2*ebno)));  
 
 nymbols=12000;
 a=zeros(1,nymbols); 
 m=4; %upsampling factor
 for i=1:nymbols 
    a(i)=out(nsym_up*m +1 + (m*(i-1)));  % a(i) are the final samples of the signal after the output filter
 end
 b=zeros(1,nymbols);
 for i=1:nymbols 
    b(i)=in(nsym_up*m/2 +1 + (m*(i-1)));  %b(i) are the final samples of the input signal to the output filter
 end  
 scatter(real(a),imag(a)); 
 %scatter(real(b),imag(b));

end