%Created by Morgan McNulty, SEAP, 7-15-2019

%7.3 Fan Airflow Rate at Test Conditions
    %7.3.2.2 Beta Ratio
        %The ratio of nozzle exit diameter to approach duct diameter
        
        %@parameter D6 = diameter of nozzle 6 (ft)
        %@parameter D5 = diameter of nozzle 5 (ft)
        %@return beta = beta ratio (unitless)
function [beta] = calcBetaRatio(D6, D5)
%eq. 7.13
    beta = D6/D5;
end