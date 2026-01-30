function [peak_valid, peak_index, lost_valid, lost_index] = pt_V2(x_in, fs)
    %#codegen
        persistent y_lpf y_hpf y_diff y_sq y_mw init_done
    
        if isempty(init_done)
            y_lpf  = 0;
            y_hpf  = 0;
            y_diff = 0;
            y_sq   = 0;
            y_mw   = 0;
            init_done = true;
        end
        y_lpf  = fimath_pt_lpf(x_in);
        y_hpf  = fimath_pt_hpf(y_lpf);
        y_diff = fimath_pt_diff(y_hpf, fs);
        y_sq   = y_diff * y_diff;
        y_mw   = fimath_pt_mw(y_sq);
        [peak_valid, peak_index, lost_valid, lost_index] = ...
            pt_peak_hw(y_mw, fs);
end
