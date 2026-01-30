function y_out = fimath_pt_lpf(x_in)
%#codegen
    Tin = numerictype(1,14,3);
    Tacc = numerictype(1, 20, 3);  
    Tout = Tin; 
    F = fimath( ...
      'RoundingMethod','Floor', ...
      'OverflowAction','Saturate', ...
      'SumMode','FullPrecision', ...
      'ProductMode','FullPrecision');
    persistent udx1 udx2 udx3 udx4 udx5 udx6 udx7 udx8 udx9 udx10 udx11 udx12 ...
               udy1 udy2 h0x h6x h12x h1y h2y;
    if isempty(udx1)
        udx1  = fi(0,Tin,F); udx2  = fi(0,Tin,F); udx3  = fi(0,Tin,F);
        udx4  = fi(0,Tin,F); udx5  = fi(0,Tin,F); udx6  = fi(0,Tin,F);
        udx7  = fi(0,Tin,F); udx8  = fi(0,Tin,F); udx9  = fi(0,Tin,F);
        udx10 = fi(0,Tin,F); udx11 = fi(0,Tin,F); udx12 = fi(0,Tin,F);
        udy1  = fi(0,Tin,F); udy2  = fi(0,Tin,F); h0x   = fi(1,Tin,F);
        h6x   = fi(-2,Tin,F);h12x  = fi(1,Tin,F); h2y   = fi(-1,Tin,F);
        h1y   = fi(2,Tin,F);
    end
    xin=fi(x_in,Tin,F);
    acc = fi(0, Tacc, F);
    acc = acc + xin*h0x;
    acc = acc + udx6*h6x;
    acc = acc + udx12*h12x;
    acc = acc + udy1*h1y;
    acc = acc + udy2*h2y;
    yout = fi(acc, Tout, F);
    y_out=double(yout);
    udx12=udx11;    udx8=udx7;  udx4=udx3;  udy2=udy1;
    udx11=udx10;    udx7=udx6;  udx3=udx2;  udy1=yout;
    udx10=udx9;     udx6=udx5;  udx2=udx1;
    udx9=udx8;      udx5=udx4;  udx1=xin;
end