import { Injectable } from "@angular/core";
// import Web3 from web3.js
import Web3 from "web3";

// import exhibition contract from exhibition.json file
// which saved when deployed the contract.
declare let window: any;

@Injectable()
export class Web3Service {
  web3: Web3;


  private abi = [
    {
      "constant": false,
      "inputs": [],
      "name": "clearAll",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [],
      "name": "clearBetters",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [],
      "name": "clearBisons",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [],
      "name": "electWinner",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_bisonName",
          "type": "bytes32"
        }
      ],
      "name": "placeBet",
      "outputs": [],
      "payable": true,
      "stateMutability": "payable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_price",
          "type": "uint256"
        }
      ],
      "name": "setPrice",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "payable": true,
      "stateMutability": "payable",
      "type": "fallback"
    },
    {
      "inputs": [
        {
          "name": "_initialBisonNames",
          "type": "bytes32[]"
        },
        {
          "name": "_initialMaxDistances",
          "type": "uint256[]"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_bisonNameList",
          "type": "bytes32[]"
        },
        {
          "name": "_maxDistances",
          "type": "uint256[]"
        }
      ],
      "name": "updateData",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getBisonData",
      "outputs": [
        {
          "name": "",
          "type": "uint256[]"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getBisonNames",
      "outputs": [
        {
          "name": "",
          "type": "bytes32[]"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getPrice",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "_bisonName",
          "type": "bytes32"
        }
      ],
      "name": "totalBetsFor",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "totalBetsForAllBisons",
      "outputs": [
        {
          "name": "",
          "type": "uint256[]"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "totalPot",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ];



  // address where contract is deployed.
  private contractDeployedAt = "0xfd39b75ea171d25efeed020a1b1e5270f510161c";
  private bisonCasino = null;
  private accounts: string[];

  constructor() {
    // call createWeb3
    this.createWeb3();
  }

  logAccounts() {
    console.log(this.accounts);
  }


  async getBisonData() {
    return await this.bisonCasino.methods.getBisonData().call();
  }

  async getBisonNames() {
    return await this.bisonCasino.methods.getBisonNames().call();
  }

  async showBalance() {
    return await this.bisonCasino.methods.showBalance().call();
  }

  async totalPot() {
    return await this.bisonCasino.methods.showBalance().call();
  }


  async placeBet(bisonName: string) {
    let res = await this.bisonCasino.methods.placeBet(this.web3.utils.fromAscii(bisonName)).send({
      from: this.accounts[0],
      value: 100000000000000000
    });
    console.log(res);
  }

  async totalBetsForAllBisons() {
    return await this.bisonCasino.methods.totalBetsForAllBisons().call();
  }






  private async createWeb3() {
    // Checking if Web3 has been injected by the browser (MetaMask)
    if (typeof window.web3 !== "undefined") {
      // Use MetaMask's provider
      this.web3 = new Web3(window.web3.currentProvider);

      //create a exhibition contract instance
      this.bisonCasino = new this.web3.eth.Contract(
        this.abi, // contract interface
        this.contractDeployedAt // address where contract is deployed
      );

      this.accounts = await this.web3.eth.getAccounts();

      console.log(this.accounts);
    } else {
      console.log("No web3? Please trying with MetaMask!");
    }
  }
}
