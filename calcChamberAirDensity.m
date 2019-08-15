%Created by Morgan McNulty, SEAP, 7-15-2019

%7.2 Density and Viscosity of Air
    %7.2.2 Duct or Chamber Air Density
    
    %calculates the air density of a duct or chamber using atmospheric air
    %density, ambient dry bulb temperature, dry bulb temperature at plane
    %x, static pressure at plane x, and ambiient barometric pressure
    %calculations are preformed in I-P units
   
    %@parameter td0 = ambient dry bulb temperature (F)
    %@parameter tdx = dry bulb temperature at plane x (F)
    %@parameter Psx = static pressure at plane x (in. wg)
    %@parameter pb = ambient barometric pressure(in. Hg)
    %@parameter dewpt = ambient dew point temperature (F)
    %@return px = air density in duct or chamber at plane x (lbm / ft^3)
    
function [ px ] = calcChamberAirDensity( td0, tdx, Psx, pb, dewpt )
    %eq 7.4 I-P
    p0 = calcAtmAirDensity(pb, td0, dewpt);
    px = p0*((td0+459.67)/(tdx+459.67))*((Psx+(pb))/(pb));
end

