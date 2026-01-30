function y_out = fimath_pt_hpf(x_in)
%#codegen
    Tin  = numerictype(1,16,12);
    Tacc = numerictype(1,28,14);
    Tout = Tin;
    F = fimath( ...
        'RoundingMethod','Floor', ...
        'OverflowAction','Saturate', ...
        'SumMode','FullPrecision', ...
        'ProductMode','FullPrecision');
    persistent udx udy1
    if isempty(udx)
        udx  = fi(zeros(1,32), Tin, F);   % línea de retardos
        udy1 = fi(0, Tout, F);
    end
    xin = fi(x_in, Tin, F);
    acc = fi(0, Tacc, F);
    acc = acc + udy1;
    acc = acc - bitsra(xin,5);
    acc = acc + udx(16);
    acc = acc - udx(17);
    acc = acc + bitsra(udx(32),5);
    y = fi(acc, Tout, F);
    y_out = double(y);
    udx(2:32) = udx(1:31);
    udx(1) = xin;
    udy1 = y;
end
