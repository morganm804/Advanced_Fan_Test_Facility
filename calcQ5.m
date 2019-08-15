%Created by Morgan McNulty, SEAP, 7-15-2019

%7.3 Fan Airflow Rate at Test Conditions
    %7.3.2.8 Airflow Rate for Chamber Nozzles
    %Calculates the airflow rate at the entrance to a nozzle or
    %multiple nozzles with chamber approach

    %@parameter td0 = ambient dry bulb temperature (F)
    %@parameter td5 = dry bulb temperature at plane 5 (F)
    %@parameter td6 = dry bulb temperature at plane 6 (F)
    %@parameter dewpt = ambient dew point temperature (F)
    %@parameter Ps5 = static pressure reading from plane 5 (in wg)
    %@parameter pb = ambient barometric pressure (in Hg)
    %@parameter deltaP = press. diff. between plane 5 and plane 6 (in wg)
    %@parameter D6 = diameter of nozzle at plane 6 (ft)
    %@parameter D5 = diameter of nozzle at plane 5 (ft)
    %@parameter E = Energy Factor
    %@parameter LD = L/D ratio (dimensionless)
    %@return Q5 = airflow rate through nozzle at plane 5(cfm)
    
function [Q5] = calcQ5(td0, td5, td6, dewpt, Ps5, pb, deltaP, D6, D5, E, LD)
    sum = 0;    
    for nozzle = D6
        if ~nozzle ==0 
        %eq. 7.15
            Y = calcExpansionFactor(Ps5, pb, nozzle, D5, deltaP, td0, td5, dewpt);
        %eq. 7.4 I-P
            rho5 = calcChamberAirDensity(td0, td5, Ps5, pb, dewpt);
        %eq. 7.20
            C = calcDischargeCoeff(td6, nozzle, Ps5, D5, deltaP, td0, td5, pb, dewpt, E, LD);
            A6 = pi * (nozzle/2)^2;
            sum = sum + (C*A6);
        end
    end
%eq. 7.22 I-P
    Q5 = 1097.8*Y*sqrt(deltaP/rho5)*sum;
end