%Created by Morgan McNulty, SEAP, 7-15-2019

%7.3 Fan Airflow rate at test conditions
    %7.3.2.1 Alpha ratio 
        %calculates the alpha ratio (ratio of absolute nozzle exit pressure to
        %absolute approach pressure)

        %@parameter deltaP = pres. diff. between plane 5 and plane 6 (in wg)
        %@parameter td0 = ambient dry bulb temperature (F)
        %@parameter td5 = dry bulb temperature at plane 5 (F)
        %@parameter Ps5 = static pressure reading from plane 5 (in wg)
        %@parameter pb = ambient barometric pressure (in Hg)
        %@parameter dewpt = ambient dew point temperature (F)
        %@return a = alpha ratio (unitless)
    
function [alpha] = calcAlphaRatio(deltaP, td0, td5, Ps5, pb, dewpt)
%eq. 7.12 I-P
    R = 53.35; 
    rho5 = calcChamberAirDensity(td0, td5, Ps5, pb, dewpt);
    alpha = 1-((5.2014*deltaP)/(rho5*R*(td5+459.67)));
end
    
