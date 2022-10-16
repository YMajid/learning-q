testCases:(
    (2 7 11 15; 9;0 1);
    (3 2 4;6;1 2);
    (3 3;6;0 1);
    (4 9 1 6 7 5 5 18;9;0 5)
    );

twoSum:{[nums;target]
    t:([]num:nums;comp:target-nums);
    possiblePairs:select from t where comp in num;
    pairIdx:{distinct raze where each y=/:x}[;nums] each possiblePairs;
    :2#first pairIdx where 1<count each pairIdx;
    };

show twoSum .' testCases[;0 1];
