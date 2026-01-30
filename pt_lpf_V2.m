function y_out = pt_lpf_V2(x_in)
    %#codegen
    h0x= 1; h6x=-2; h12x=1; h1y=2; h2y=-1;
    persistent udx udy
        if isempty(udx)
            udx=zeros(1,12);
            udy=zeros(1,2);
        end
    y_out = x_in*h0x + ...
            udx(6)*h6x + ...
            udx(12)*h12x + ...
            udy(1)*h1y + ...
            udy(2)*h2y;
    udx = [x_in udx(1:end-1)];
    udy = [y_out udy(1)];

end
