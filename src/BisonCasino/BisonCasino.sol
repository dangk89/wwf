pragma solidity ^0.4.24;

// CHALLENGES: people cannot place multiple bets

contract BisonCasino {

    // WWF's address which will receive %5 of winners' earnings
    address owner;

    uint constant BET_AMOUNT = 1000;

    struct Bison {
        uint max_distance_daily;
        uint max_alt;
        //max...
    }

    bytes32[] bisonNames;
    mapping(bytes32 => Bison) bisons;

    address[] betters;
    mapping(address => bytes32) bets;


    constructor (bytes32[] initialBisonNames) public payable {
        bisonNames = initialBisonNames;

        owner = msg.sender;
    }

    function placeBet(bytes32 bisonName) public payable {
        require(bisonExists(bisonName));
        //require(msg.value == BET_AMOUNT);

        betters.push(msg.sender);
        bets[msg.sender] = bisonName;
    }

    function totalBetsFor(bytes32 bisonName) public view returns (uint) {
        require(bisonExists(bisonName));

        // count total bets
        uint totalBets = 0;
        for(uint i = 0; i < betters.length; i++) {
            address better = betters[i];
            if(bets[better] == bisonName) {
                totalBets += 1;
            }
        }
        return totalBets;
    }

    function totalPot() public view returns (uint) {
        uint pot = 0;
        for(uint i = 0; i < betters.length; i++) {
            pot += BET_AMOUNT;
        }
        return pot;
    }

    function bisonExists (bytes32 bisonName) private view returns (bool) {
        for(uint i = 0; i < bisonNames.length; i++) {
            if(bisonNames[i] == bisonName) {
                return true;
            }
        }
        return false;
    }

    function electWinner() public {
        // find best bison
        bytes32 bestBison = "";
        for(uint i = 0; i < bisonNames.length; i++) {
            if(i == 0) {
                bestBison = bisonNames[i];
            } else {
                bytes32 newBison = bisonNames[i];
                if(bisons[newBison].max_distance_daily > bisons[bestBison].max_distance_daily) {
                    bestBison = newBison;
               }
            }
        }

        // calculate winnings and profit
        uint split = totalPot() / totalBetsFor(bestBison);
        uint wwfcut = 5*split/100;
        uint payout = split - wwfcut;

        // transfer winnings and profit
        for(uint j = 0; j < betters.length; j++) {
            address better = betters[j];
            if(bets[better] == bestBison) {
                better.transfer(payout);
            }
        }

        owner.transfer(wwfcut);

        // clear bets
        delete betters;
        // OR
        betters.length = 0;
    }
}
