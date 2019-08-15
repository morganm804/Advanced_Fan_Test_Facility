%Created by Morgan McNulty, SEAP, 7-15-2019

%7.3 Fan Airflow Rate at Test Conditions
    %7.3.9 Fan Airflow Rate
    
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
    %@return Q = fan airflow rate(cfm)

function [Q] = calcQ(td0, td5, td6, dewpt, Ps5, pb, deltaP, D6, D5, E, LD)
%eq. 7.22 I-P
    Q5 = calcQ5(td0, td5, td6, dewpt, Ps5, pb, deltaP, D6, D5, E, LD);
%eq. 7.4 I-P
    rho5 = calcChamberAirDensity( td0, td5, Ps5, pb, dewpt );
%eq. ?
    rho = calcAtmAirDensity(pb, td0, dewpt);
%eq. 7.23
    Q = Q5 *(rho5/rho);
end