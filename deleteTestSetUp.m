function deleteTestSetUp( index )
        load('testSetUps');
        namesList(:, index) = [];
        testSetUpList(:, index) = [];

        save('testSetUps','testSetUpList', 'namesList');
end

