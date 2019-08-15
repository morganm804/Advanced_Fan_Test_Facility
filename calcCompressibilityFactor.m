%7.8 Fan Efficiency
    %7.8.2 Compressibility Factor
    
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
  %@return Kp = compressibility factor
  
  function [Kp] = calcCompressibilityFactor(td0, td5, td6, dewpt, Ps7, Ps5, Ps2, pb, deltaP, D2, D6, D5, E, LD)
    
    Pt = calcPt(td0, td5, td6, td2, dewpt, Ps7, Ps5, Ps2, pb, deltaP, D2, D6, D5, E, LD);
    %eq. 7.38
    Pt1 = 0;
    
    Q = calcQ(td0, td5, td6, dewpt, Ps5, pb, deltaP, D6, D5, E, LD);
    H = calcTorsionElement(T, N);
    %gamma is the isentropic exponenet, taken as 1.4 for air
    gamma = 1.4;
    %eq. 7.54 I-P
    x = Pt / (Pt1+pb);
    %eq. 7.55 I-P
    z = ((gamma-1)/gamma)*(((6343.3*H)/Q)/(Pt1 + (13.595*pb)));
    %eq 7.56
    Kp = (log(1+x)/x)*(z/log(1+z));
end 