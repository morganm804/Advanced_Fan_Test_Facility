%Created by Morgan McNulty, SEAP, 7-15-2019

%7.3 Fan Airflow Rate at Test Conditions
    %7.3.2.6 Discharge Coefficient
    
    %Nozzle discharge coefficient (for L/D = .5)is calculated using iterative appraoch
    %illustrated in Annex G
    
      %@parameter td6 = dry bulb temperature at plane 6(F)
      %@parameter D6 = diameter of nozzle at plane 6 (ft)
      %@parameter Ps5pt = static pressure reading from plane 5 (in wg)
      %@parameter D5 = diameter of nozzle at plane 5 (ft)
      %@parameter deltaPpt = pres. diff. between plane 5 and plane 6 (in wg)
      %@parameter td0 = ambient dry bulb temperature(F)
      %@parameter td5 = dry bulb temperature at plane 5 (F)
      %@parameter pb = ambient barometric pressure (in Hg)
      %@parameter dewpt = ambient dew point temperature (F)
      %@parameter E = Energy Factor
      %@parameter LD = L/D ratio (dimensionless)
      %@return C = nozzle discharge coefficient to the nearest thousandth

function [C] = calcDischargeCoeff(td6, D6, Ps5pspt, D5, deltaPpt, td0, td5, pb, dewpt, E, LD)
%eq. 7.6 I-P
    mu6 = calcDynamicAirViscosity(td6);
    guessC1 = .9986;
%eq. 7.15
    Y = calcExpansionFactor(Ps5pspt, pb, D6, D5, deltaPpt, td0, td5, dewpt);
%eq. 7.4 I-P
    rho5 = calcChamberAirDensity(td0, td5, Ps5pspt, pb, dewpt);
%eq. 7.13
    beta = calcBetaRatio(D6, D5);
%eq. 7.18 I-P    
    guessRe = (1097.8/ (60*mu6))*(guessC1*D6*Y)*sqrt((deltaPpt*rho5)/(1-(E*(beta^4))));
%eq. 7.20
    if LD==0.5
        guessC2 = 0.9986 - (6.688/sqrt(guessRe)) + (131.5/guessRe);
    else
        guessC2 = 0.9986 - (7.006/sqrt(guessRe)) + (134.6/guessRe);
    end
    
    while(abs(guessC1 - guessC2)>.001)
        guessC1 = guessC2;
        %eq. 7.18 I-P  
        guessRe = (1097.8/ (60*mu6))*(guessC1*D6*Y)*sqrt((deltaPpt*rho5)/(1-(E*(beta^4))));
        %eq. 7.20
        if LD==0.5
            guessC2 = 0.9986 - (6.688/sqrt(guessRe)) + (131.5/guessRe);
        else
            guessC2 = 0.9986 - (7.006/sqrt(guessRe)) + (134.6/guessRe);
        end
    end
    
    C = guessC2;
end