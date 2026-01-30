function y_out = pt_diff(x_in,fs)
%#codegen
h0=1; h1=2; h2=0; h3=-2; h4=-1;
persistent ud1 ud2 ud3 ud4;
if isempty(ud1)
    ud1=0; ud2=0; ud3=0; ud4=0;
end
y_out=(fs/8)*(h0*x_in+h1*ud1+h2*ud2+h3*ud3+h4*ud4);
ud4=ud3;
ud3=ud2;
ud2=ud1;
ud1=x_in;
end
