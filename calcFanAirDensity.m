%Created by Morgan McNulty, SEAP, 7-15-2019

%7.2 Denisty and Viscosity of Air
    %7.2.3 Fan Air Density
    
    %calculates the fan air density using atmospheric air
    %density, the total pressure at the fan inlet and the stagnation
    %(total) temperature at the fan inlet (ts1)
    %calculations are preformed in I-P units
   
    %@parameter pt1 = total pressure at fan inlet(in. wg)
    %@parameter pb = ambient barometric pressure(in. Hg)
    %@parameter td0 = ambient dry bulb temperature (F)
    %@parameter ts1 =total temperature at fan inlet (F)
    %@parameter dewpt = dew point temperature (F)
    %@return p = fan air density( (lbm / ft^3)
    
function [ p ] = calcFanAirDensity( pt1, pb, td0, ts1, dewpt ) 
%eq 7.5 I-P
    p0 = calcAtmAirDensity(pb, td0, dewpt);
    p = p0*((pt1+(13.595*pb))/(13.595*pb))*((td0+459.67)/(ts1 + 459.67));
end
