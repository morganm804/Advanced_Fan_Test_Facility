function [ currentSetUpIndex ] = readSetUp( setUp )
    load('testSetUps');
    for i = 1:length(namesList)
        if strcmp(namesList(i), setUp)
            currentSetUpIndex = i;
        end
    end
end

