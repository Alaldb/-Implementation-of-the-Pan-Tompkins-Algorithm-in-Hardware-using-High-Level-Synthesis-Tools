function [index_out, lost_peak_index] = pt_peak_detection_V3(x_in,fs)
%#codegen
persistent actual_index last_peak_index T1 T2 SPKI NPKI last_value...
           RR7 RR6 RR5 RR4 RR3 RR2 RR1 ...
           possible_peak possible_peak_index...
           peak_candidate index_candidate

if isempty(actual_index)
    actual_index=1; last_peak_index=1; last_value=0;
    SPKI=0; NPKI=0;
    T1=NPKI+0.25*(SPKI-NPKI);
    T2=0.5*T1;
    RR7=0; RR6=0; RR5=0; RR4=0; RR3=0; RR2=0; RR1=0;
    possible_peak=0; possible_peak_index=0;
    peak_candidate=0; index_candidate=0;
end
RR=actual_index-last_peak_index;
RR_MISSED_LIMIT=1.66*mean([RR, RR1, RR2, RR3, RR4, RR5, RR6, RR7]);
index_out=0;
lost_peak_index=0;
if x_in>T1
    if actual_index>200 && (x_in>=peak_candidate) && (actual_index-last_peak_index)>0.2*fs
        index_candidate=actual_index;
        peak_candidate=x_in;
    end
        index_out=0;
    last_peak_index=actual_index;
    SPKI=0.125*x_in+0.875*SPKI;
    RR7=RR6; RR6=RR5; RR5=RR4;
    RR4=RR3; RR3=RR2; RR2=RR1; RR1=RR;

else
    if ~isempty(peak_candidate)
        index_out=index_candidate;
        peak_candidate=0;
        index_candidate=0;
    end
    if (RR>RR_MISSED_LIMIT) && ...
       (possible_peak<T1) && ...
       (possible_peak>T2) && ...
       (possible_peak_index>last_peak_index) && ...
       (possible_peak_index<actual_index)
        if actual_index>200
            lost_peak_index=possible_peak_index;
        else
            lost_peak_index=0;
        end
        last_peak_index=possible_peak_index;
    end
    if x_in>possible_peak
        possible_peak=x_in;
        possible_peak_index=actual_index;
    end
    NPKI=0.125*x_in+0.875*NPKI;
end
T1=NPKI+0.25*(SPKI-NPKI);
T2=0.5*T1;
actual_index=actual_index+1;
last_value=x_in;
end
