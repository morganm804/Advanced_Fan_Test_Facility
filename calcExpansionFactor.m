%Created by Morgan McNulty, SEAP, 7-15-2019

%7.3 Fan Airflow rate at test conditions
    %7.3.2.1 Expansion Factor 
    %calculates the expansion factor
    
    %@parameter Ps5 = static pressure reading from plane 5 (in wg)
    %@parameter pb = ambient barometric pressure (in Hg)
    %@parameter D6 = diameter of nozzle at plane 6 (ft)
    %@parameter D5 = diameter of nozzle at plane 5 (ft)
    %@parameter deltaP = pres. diff. between plane 5 and plane 6 (in wg)
    %@parameter td0 = ambient dry bulb temperature (F)
    %@parameter td5 = dry bulb temperature at plane 5 (F)
    %@parameter dewpt = ambient dew point temperature (F)
    %@return Y = expansion factor
    
function [Y] = calcExpansionFactor(Ps5, pb, D6, D5, deltaP, td0, td5, dewpt)
%eq. 7.11 I-P
    a = calcAlphaRatio(deltaP, td0, td5, Ps5, pb, dewpt);
%eq. 7.13 
    b = calcBetaRatio(D6, D5);
%eq. 7.14
    Y = 1 - ((0.548 + (.71*(b^4)))*(1-a));
end