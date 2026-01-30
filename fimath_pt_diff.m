function y_out = fimath_pt_diff(x_in,fs)
%#codegen
    Tin  = numerictype(1,16,12);
    Tacc = numerictype(1,24,14);
    Tout = Tin;
    F = fimath( ...
        'RoundingMethod','Floor', ...
        'OverflowAction','Saturate', ...
        'SumMode','FullPrecision', ...
        'ProductMode','FullPrecision');
    h0 = fi( 1, Tin, F);
    h1 = fi( 2, Tin, F);
    h3 = fi(-2, Tin, F);
    h4 = fi(-1, Tin, F);
    persistent ud
    if isempty(ud)
        ud = fi(zeros(1,4), Tin, F);   % [x[n-1] ... x[n-4]]
    end
    xin = fi(x_in, Tin, F);
    fs=fi(fs/8,Tin,F);
    acc = fi(0, Tacc, F);
    acc = acc+ fs + xin*h0;
    acc = acc + ud(1)*h1;
    acc = acc + ud(3)*h3;
    acc = acc + ud(4)*h4;
    yfix = fi(acc, Tout, F);
    y_out = double(yfix);
    ud(4) = ud(3);
    ud(3) = ud(2);
    ud(2) = ud(1);
    ud(1) = xin;
end
