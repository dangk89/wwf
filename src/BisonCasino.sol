pragma solidity ^0.4.24;

contract BisonCasino {

    // WWF's address which will receive %5 of winners' earnings
    address owner;

    uint constant BET_AMOUNT = 1000;

    bytes32[] bisonNames;
    mapping(bytes32 => uint) bisons;

    address[] betters;
    mapping(address => bytes32) bets;


    constructor (bytes32[] _initialBisonNames, uint[] _initialMaxDistances) public payable {
        updateData(_initialBisonNames, _initialMaxDistances);

        owner = msg.sender;
    }

    function () public payable {
    }

    function updateData(bytes32[] _bisonNameList, uint[] _maxDistances) public {
        //require(msg.sender == owner, "Only the owner can update data");
        require(_bisonNameList.length == _maxDistances.length, "Data lists must be of same size");

        for(uint i = 0; i < _bisonNameList.length; i++) {
            bytes32 bisonName = _bisonNameList[i];

            if(!bisonExists(bisonName))
                bisonNames.push(bisonName);
            bisons[bisonName] = _maxDistances[i];
        }
    }

    function placeBet(bytes32 _bisonName) public payable {
        require(bisonExists(_bisonName), "Bison does not exist");
        require(!betterExists(msg.sender), "This address already placed a bet");
        require(msg.value == BET_AMOUNT, "You must bet exactly BET_AMOUNT");

        betters.push(msg.sender);
        bets[msg.sender] = _bisonName;
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

    function showBalance() public view returns (uint) {
        return address(this).balance;
    }

    function totalPot() public view returns (uint) {
        return betters.length * BET_AMOUNT;
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

        // clear bets
        delete betters;
        // OR
        betters.length = 0;
    }
}
