function addNewTestSetUp(name, testUnit, D5,D6Type, D6,LD, a,b, testPersonnel, transitionDim, notes)
    load('testSetUps');

    n = length(testSetUpList)+1;

    testSetUpList(n) = testSetUp(name, testUnit, D5,D6Type, D6,LD, a,b, testPersonnel, transitionDim, notes);
    namesList{n} = name;

    save('testSetUps','testSetUpList', 'namesList');
end