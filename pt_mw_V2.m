function y_out = pt_mw_V2(x_in)
    %#codegen
    persistent udx_vector
    persistent y_tmp
    
    if isempty(udx_vector) || isempty(y_tmp)
        udx_vector = zeros(1,64);
        y_tmp = 0;
    end
    
    y_tmp = x_in;
    for i=1:64
        y_tmp = y_tmp + udx_vector(i);
    end    
    y_out = y_tmp / 64;
    
    udx_vector(1) = x_in;
    for i=2:64
        udx_vector(i) = udx_vector(i-1);
    end

end
