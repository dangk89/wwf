pragma solidity ^0.4.24;

contract BisonCasino {

    // WWF's address which will receive %5 of winners' earnings
    address owner;

    uint BET_AMOUNT = 1000;

    /* Data structures */
    bytes32[] bisonNames;
    mapping(bytes32 => uint) bisons;

    address[] betters;
    mapping(address => bytes32) bets;


    /* Constructor and fallback function */
    constructor (bytes32[] _initialBisonNames, uint[] _initialMaxDistances) public {
        updateData(_initialBisonNames, _initialMaxDistances);

        owner = msg.sender;
    }

    function () public payable {
    }

    /* Read-write functions */
    function updateData(bytes32[] _bisonNameList, uint[] _maxDistances) public {
        //require(msg.sender == owner, "Only the owner can update data");
        require(_bisonNameList.length == _maxDistances.length, "Data lists must be of same size");

        for(uint i = 0; i != _bisonNameList.length; i++) {
            bytes32 bisonName = _bisonNameList[i];

            if(!bisonExists(bisonName))
                bisonNames.push(bisonName);
            bisons[bisonName] = _maxDistances[i];
        }
    }

    function setPrice(uint _price) public {
        //require owner
        BET_AMOUNT = _price;
    }

    function placeBet(bytes32 _bisonName) public payable {
        require(bisonExists(_bisonName), "Bison does not exist");
        require(!betterExists(msg.sender), "This address already placed a bet");
        require(msg.value == BET_AMOUNT, "You must bet exactly BET_AMOUNT");

        betters.push(msg.sender);
        bets[msg.sender] = _bisonName;
    }

    function electWinner() public {
        uint i;

        // find best bison
        bytes32 bestBison = "";
        for(i = 0; i < bisonNames.length; i++) {
            bytes32 newBison = bisonNames[i];

            if(i == 0) {
                bestBison = newBison;
            } else {
                if(bisons[newBison] > bisons[bestBison]) {
                    bestBison = newBison;
                }
            }
        }

        // calculate winnings and profit
        uint wwfcut = totalPot() / 20;
        uint payout = totalPot() - wwfcut;

        uint bestBisonBets = totalBetsFor(bestBison);
        if(bestBisonBets > 0) {
            uint split = payout / bestBisonBets;

            // transfer winnings and profit
            for(i = 0; i < betters.length; i++) {
                address better = betters[i];

                if(bets[better] == bestBison) {
                    better.transfer(split);
                }
            }
        }

        owner.transfer(address(this).balance);

        betters.length = 0;
    }

    function clearBisons() public {
        bisonNames.length = 0;
    }

    function clearBetters() public {
        betters.length = 0;
    }

    function clearAll() public {
        clearBisons();
        clearBetters();
    }

    /* Read-only functions */
    function getPrice() public view returns (uint) {
        return BET_AMOUNT;
    }

    function getBisonNames() public view returns (bytes32[]) {
        return bisonNames;
    }

    function getBisonData() public view returns (uint[]) {
        uint[] memory bisonData = new uint[](bisonNames.length);
        for(uint i = 0; i < bisonNames.length; i++) {
            bytes32 bison = bisonNames[i];
            bisonData[i] = bisons[bison];
        }
        return bisonData;
    }

    function totalBetsFor(bytes32 _bisonName) public view returns (uint) {
        require(bisonExists(_bisonName), "Bison does not exist");

        // count total bets
        uint totalBets = 0;
        for(uint i = 0; i < betters.length; i++) {
            address better = betters[i];

            if(bets[better] == _bisonName) {
                totalBets += 1;
            }
        }
        return totalBets;
    }

    function totalBetsForAllBisons() public view returns (uint[]) {
        uint[] memory betArray = new uint[](bisonNames.length);
        for(uint i = 0; i < bisonNames.length; i++) {
            bytes32 bison = bisonNames[i];

            betArray[i] = totalBetsFor(bison);
        }
        return betArray;
    }

    function totalPot() public view returns (uint) {
        return betters.length * BET_AMOUNT;
    }

    function bisonExists (bytes32 _bisonName) private view returns (bool) {
        for(uint i = 0; i < bisonNames.length; i++) {
            if(bisonNames[i] == _bisonName) {
                return true;
            }
        }
        return false;
    }

    function betterExists (address _better) private view returns (bool) {
        for(uint i = 0; i < betters.length; i++) {
            if(betters[i] == _better) {
                return true;
            }
        }
        return false;
    }

    function test_constructor_success() public view returns (bool){
    return (msg.sender == owner);
}

bytes32[] bisonNameList_success;
uint[] maxDistances_success;
function test_updateData_success() public returns (bool){
    bisonNameList_success.push("0x1");
    maxDistances_success.push(42);
    updateData(bisonNameList_success,maxDistances_success);
    return true;
}

bytes32[] bisonNameList_failure;
uint[] maxDistances_failure;
function test_updateData_differentSize() public returns (bool){
    bisonNameList_failure.push("0x1");
    updateData(bisonNameList_failure,maxDistances_failure);
    return false;
}

function test_placeBet_noSuchBison() public returns (bool){
    placeBet("0x2");
    return false;
}

function test_placeBet_alreadyPlaced() public returns (bool){
    bisonNames.push("0x3");
    placeBet("0x3");
    placeBet("0x3");
    return false;
}

function test_placeBet_wrongAmount() public returns (bool){
    bisonNames.push("0x4");
    placeBet("0x4");
    return false;
}

function test_placeBet_success() public payable returns (bool){
    bisonNames.push("0x5");
    placeBet("0x5");
    return (bets[msg.sender] == "0x5");
}

function test_totalBetsFor_success() public payable returns (bool){
    bisonNames.push("0x6");
    placeBet("0x6");
    return (totalBetsFor("0x6") == 1);
}

function test_totalPot_success() public payable returns (bool){
    bisonNames.push("0x7");
    placeBet("0x7");
    return (totalPot() == (1*BET_AMOUNT)  );
}

function test_getBisonNames_success() public returns (bool){
    bisonNames.push("0x8");
    bisonNames.push("0x9");
    bisonNames.push("0x10");
    return (getBisonNames().length == 3);
}

}

