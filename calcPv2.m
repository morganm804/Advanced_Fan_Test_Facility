%Created by Morgan McNulty, SEAP, 7-15-2019  

%7.4 Fan Velocity Pressure at Test Conditions
    %7.4.2 Nozzle
    %Calculates fan velocity pressure using velocity and air denisty at the
    %fan outlet

    %@parameter td0 = ambient dry bulb temperature (F)
    %@parameter td5 = dry bulb temperature at plane 5 (F)
    %@parameter td6 = dry bulb temperature at plane 6 (F)
    %@parameter td2 = dry bulb temperature at plane 2 (F)
    %@parameter dewpt = ambient dew point temperature (F)
    %@parameter Ps5 = static pressure reading from plane 5 (in wg)
    %@paramter Ps2 = static pressure reading from plane 2 (in wg)
    %@parameter pb = ambient barometric pressure (in Hg)
    %@parameter deltaP = pres. diff. between plane 5 and plane 6 (in wg)
    %@parameter D2 = diameter of nozzle at plane 2 (in^2)
    %@parameter D6 = diameter of nozzle at plane 6 (ft)
    %@parameter D5 = diameter of nozzle at plane 5 (ft)
    %@parameter E = Energy Factor (unitless)
    %@parameter LD = L/D ratio (dimensionless)
    %@return Pv2 = fan velocity pressure (in wg)
    
function [Pv2] = calcPv2(td0, td5, td6, td2, dewpt, Ps5, Ps2, pb, deltaPpt, D2, D6, D5,E, LD)
%eq. 7.26
    V2 = calcV2(td0, td5, td6, td2, dewpt, Ps5, Ps2, pb, deltaPpt, D2, D6, D5, E, LD);
%eq. 7.4 I-P
    rho2 = calcChamberAirDensity(td0, td2, Ps2, pb, dewpt);
%eq. 7.27 I-P
    Pv2 = ((V2/1097.8)^2)*rho2;
end