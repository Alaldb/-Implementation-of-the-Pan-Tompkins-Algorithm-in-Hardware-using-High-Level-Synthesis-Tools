function [peak_index, lost_index] = pt(x_in, fs)
    persistent y_lpf y_hpf y_diff y_sq y_mw init_done
    if isempty(init_done)
        y_lpf=0; 
        y_hpf=0;
        y_diff=0;
        y_sq=0;
        y_mw=0;
        init_done = 1;
    end
    y_lpf=pt_lpf_V2(x_in);
    y_hpf=pt_hpf_V2(y_lpf);
    y_diff=pt_diff(y_hpf, fs);
    y_sq=y_diff*y_diff;
    y_mw=pt_mw_V2(y_sq);
    %[peak_index, lost_index] = pt_peak_detection_V2(y_mw);
    [peak_index, lost_index] = pt_peak_detection_V3(y_mw,fs);

end
