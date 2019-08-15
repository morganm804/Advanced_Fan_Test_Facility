%Created by Morgan McNulty, SEAP, 7-15-2019

%7.6 Fan Static Pressure at Test Conditions  
  %calculates the fan static pressure at test conditions

  %@parameter td0 = ambient dry bulb temperature (F)
  %@parameter td5 = dry bulb temperature at plane 5 (F)
  %@parameter td6 = dry bulb temperature at plane 6 (F)
  %@parameter td2 = dry bulb temperature at plane 2 (F)
  %@parameter dewpt = ambient dew point temperature (F)
  %@parameter Ps7 = static pressure reading from plane 7 (in wg)
  %@parameter Ps5 = static pressure reading from plane 5 (in wg)
  %@paramter Ps2 = static pressure reading from plane 2 (in wg)
  %@parameter pb = ambient barometric pressure (in Hg)
  %@parameter deltaP = pres. diff. between plane 5 and plane 6 (in wg)
  %@parameter D2 = diameter of nozzle at plane 2 (in^2)
  %@parameter D6 = diameter of nozzle at plane 6 (ft)
  %@parameter D5 = diameter of nozzle at plane 5 (ft)
  %@parameter E = Energy Factor (unitless)
  %@parameter LD = L/D ratio (dimensionless)
  %@return Ps = fan static pressure (in. wg.)
  
function [Ps] = calcPs(td0, td5, td6, td2, dewpt, Ps7, Ps5pt, Ps2, pb, deltaP, D2, D6, D5, E, LD)
    %figure 12 equations
    Pv2 = calcPv2(td0, td5, td6, td2, dewpt, Ps5pt, Ps2, pb, deltaP, D2, D6, D5, E, LD);
    Pv = Pv2;
    %eq 7.48
    Pt = calcPt(td0, td5, td6, td2, dewpt, Ps7, Ps5pt, Ps2, pb, deltaP, D2, D6, D5, E, LD);
    %eq. 7.49
    Ps = Pt - Pv;
    
end