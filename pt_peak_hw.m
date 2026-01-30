function [peak_valid, peak_index, lost_valid, lost_index] = pt_peak_hw(x_in, fs)
    %#codegen
    
    persistent idx last_peak_idx SPKI NPKI ...
               RR1 RR2 RR3 RR4 RR5 RR6 RR7 ...
               peak_cand peak_cand_idx ...
               poss_peak poss_peak_idx ...
               refr_count
    
    if isempty(idx)
        idx = 0;
        last_peak_idx = 0;
        SPKI = 0; NPKI = 0;
        RR1=0; RR2=0; RR3=0; RR4=0; RR5=0; RR6=0; RR7=0;
        peak_cand = 0; peak_cand_idx = 0;
        poss_peak = 0; poss_peak_idx = 0;
        refr_count = int32(0);
    end
    
    idx = idx + 1;
    
    peak_valid = false;
    lost_valid = false;
    peak_index = 0;
    lost_index = 0;

    if refr_count > 0
        refr_count = refr_count -1;
    end
    
    RR = idx - last_peak_idx;
    RR_mean = (RR1+RR2+RR3+RR4+RR5+RR6+RR7+RR) / 8;
    RR_MISS = RR_mean * 1.66;
    
    T1 = NPKI + (SPKI-NPKI)/4;
    T2 = T1 / 2;
    
    % Posible pico
    if x_in > poss_peak
        poss_peak = x_in;
        poss_peak_idx = idx;
    end
    
    % Candidato a pico
    if x_in > T1 && (idx-last_peak_idx) > 0.75*fs && refr_count == 0
        if x_in > peak_cand
            peak_cand = x_in;
            peak_cand_idx = idx;
        end
    end
    
    % Confirmación de pico
    if peak_cand > 0 && x_in < peak_cand && (idx-last_peak_idx) > 0.75*fs && refr_count == 0
        peak_valid = true;
        peak_index = peak_cand_idx;
    
        SPKI = (7*SPKI + peak_cand) / 8;
    
        RR7=RR6; RR6=RR5; RR5=RR4;
        RR4=RR3; RR3=RR2; RR2=RR1; RR1=RR;
    
        last_peak_idx = peak_cand_idx;
    
        peak_cand = 0;
        refr_count = int32(0.25*fs);
    end
    
    % Pico perdido
    if RR > RR_MISS && poss_peak > T2 && poss_peak < T1 && refr_count == 0
        lost_valid = true;
        lost_index = poss_peak_idx;
        last_peak_idx = poss_peak_idx;
        poss_peak = 0;
        refr_count = int32(0.25*fs);
    end
    
    NPKI = (7*NPKI + x_in) / 8;
    
    
end
