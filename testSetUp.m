classdef testSetUp   
    properties (Access = public)
        name, testUnit, D5, D6Type, D6, LD, a, b, testPersonnel, transitionDim, notes;
    end
    
    methods
        function newSetUp = testSetUp(name,testUnit, D5,D6Type, D6, LD, a,b, testPersonnel, transitionDim, notes)
            if nargin > 0 
                newSetUp.name = name;
                newSetUp.testUnit = testUnit;
                newSetUp.D5 = D5;
                newSetUp.D6Type = D6Type;
                newSetUp.LD = LD;
                newSetUp.D6 = D6;
                newSetUp.a = a;
                newSetUp.b = b;  
                newSetUp.testPersonnel = testPersonnel;
                newSetUp.transitionDim = transitionDim;
                newSetUp.notes = notes;
            end
        end
    end
    
end


