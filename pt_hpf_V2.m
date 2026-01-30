 function y_out = pt_hpf_V2(x_in)
    %#codegen
    h0x  = -1; h16x = 32; h32x = 1; h1y  = -1;
    persistent udx udy
        if isempty(udx)
            udx=zeros(1,32);
            udy=0;
        end
    y_out=x_in*h0x+udx(16)*h16x+udx(32)*h32x+udy*h1y;
    udx=[x_in udx(1:end-1)];
    udy=y_out;
end
