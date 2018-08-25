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

        for(uint i = _bisonNameList.length; i != 0 ; i--) {
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
}
