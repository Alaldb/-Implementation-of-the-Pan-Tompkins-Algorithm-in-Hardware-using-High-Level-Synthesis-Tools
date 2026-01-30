function y_out = fimath_pt_mw(x_in)
%#codegen

    Tin  = numerictype(1,16,12);
    Tacc = numerictype(1,28,14);
    Tout = Tin;

    F = fimath( ...
        'RoundingMethod','Floor', ...
        'OverflowAction','Saturate', ...
        'SumMode','FullPrecision', ...
        'ProductMode','FullPrecision');

    persistent udx_vector acc_sum

    if isempty(udx_vector)
        udx_vector = fi(zeros(1,64), Tin, F);
        acc_sum    = fi(0, Tacc, F);
    end

    xin = fi(x_in, Tin, F);

    %---------------------------------
    % acc_sum = acc_sum + xin
    %---------------------------------
    tmp = acc_sum + xin;               % sfix29_En14
    acc_sum = fi(tmp, Tacc, F);        % recuantización explícita

    %---------------------------------
    % acc_sum = acc_sum - udx_vector(64)
    %---------------------------------
    tmp = acc_sum - udx_vector(64);    % sfix29_En14
    acc_sum = fi(tmp, Tacc, F);

    %---------------------------------
    % División por 64
    %---------------------------------
    y = bitsra(acc_sum,6);
    y_out = double(fi(y, Tout, F));

    %---------------------------------
    % Actualizar retardos
    %---------------------------------
    udx_vector(2:64) = udx_vector(1:63);
    udx_vector(1)    = xin;
end

