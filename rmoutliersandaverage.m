%Created by Morgan McNulty, SEAP, 7-15-2019

%Removes outliers (>1 sd above or below mean) for standard deviations greater than 3 and removes outliers (>2 sd above or below mean) 
%for standard deviations less than 3, then averages remaining values
%To be used with psychometric calculations and ambient barometric pressure
function [ A ] = rmoutliersandaverage( B )
    n=0;
    sumB=0;
    for i= 1 : length(B)
        if std(B) < 3
            if abs(B(i)-mean(B))< 2*std(B)
                sumB=sumB+B(i);
                n=n+1;
            end
        else
            if abs(B(i)-mean(B)) < std(B)
                sumB=sumB+B(i);
                n=n+1;
            end
        end
    end
    
    A=sumB/n;
end

