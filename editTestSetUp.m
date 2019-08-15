function editTestSetUp(name, testUnit, D5,D6Type, D6, LD, a,b, testPersonnel, transitionDim, notes, index)

    testSetUpList(index) = testSetUp(name,testUnit, D5,D6Type, D6, LD, a,b, testPersonnel, transitionDim, notes);
    namesList{index} = name;

    save('testSetUps','testSetUpList', 'namesList');
end