%7.7 Fan Power Input at Test Conditions
    %7.7.2 Torsion Element
    
    %@parameter T = torque as measured by torsion element (lbs)
    %@parameter N = rotational speed (rpm)
    %@return H = fan power input (hp)
function [H] = calcTorsionElement(T, N)
    %eq. 7.51 I-P
    H = (2*pi*T*N)/(33000*12);
end