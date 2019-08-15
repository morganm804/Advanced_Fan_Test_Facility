%%Original Function "air" written in Visual Basic by Matt Frank Code for implementation into MS Excel
%%Converted to MATLAB by Tristan Wolfe (tristan.wolfe@navy.mil) for implementation into LabVIEW
%Edited by Morgan McNulty, SEAP, 7-16-2019

    %7.2.1 Atmospheric air density
        %Used 2013 ASHRAE Handbook equation 28 for calculating atmospheric
        %air denisty with dry bulb temp, dew point temp, and ambient
        %barometric pressure
        
        %@parameter pb = ambient barometric pressure (in. HG)
        %@parameter td0 = ambient dry bulb temperature (*F)
        %@parameter dewpt = ambient dew point temperature (*F)
        %@return rho = atmospheric air density (lbm/ft^3)
        
function [rho] = calcAtmAirDensity(pb, td0, dewpt) 
    %convert pressure from in wg to psia
    dewpt = dewpt + 459.67;
    td0 = td0 +459.67;

    error = 0;
    % diffac - factor to incorate dissolved gases, intermolecular forces and pressure forces
    %          Hyler and Weber based
    diffac = ((0.00000000758 * pb + 0.0000000002136) * td0 ^ 2) + ((-0.000002148 * pb + 0.00001123) * td0) + (0.0003 * pb + 1);
    if(dewpt > td0) 
        error = 1;
        errortext = 'dewpoint temperature must be equal to or less than the dry bulb temperature';
        dewpt = td0;
    end
    if(dewpt < 32) 
        ppreswtrv = exp((-10214.165 / (dewpt)) - 4.8932428 - (0.0053765794 * (dewpt)) + (0.00000019202377 * (dewpt) ^ 2) + (3.5575832E-10 * (dewpt) ^ 3) - (9.0344688E-14 * (dewpt) ^ 4) + (4.1635019 * log(dewpt)));
        else
        ppreswtrv = exp((-1.0440397*(10^4))/dewpt - 1.129465*10 - (2.7022355*(10^-2))*dewpt + (1.289036*(10^-5))*(dewpt^2) - (2.4780681*(10^-9))*(dewpt^3) + 6.5459673*log(dewpt));
    end
    W = 0.62198*(ppreswtrv/(pb-ppreswtrv)) ;
    rho = (pb-ppreswtrv)/(0.3704*td0*(1+1.6078*W));
    if(error == 1)
       disp(errortext);
       
    end
    
end
