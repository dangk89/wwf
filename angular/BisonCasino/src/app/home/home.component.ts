import { Component, OnInit } from '@angular/core';
import {Web3Service} from "../web3.service";
import {SelectItem} from "primeng/api";
import {mapData} from "../../assets/mapdata";
import Web3 from "web3";
declare let window: any;
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  web3: Web3;
  blockChainBisonBets = [];
  blockChainBisonNames = [];
  bisons = [];
  sortOptions: SelectItem[];
  sortKey: string;
  sortField: string;
  sortOrder: number;


  constructor(private web3Service: Web3Service) { }

  ngOnInit() {
    this.web3 = this.web3Service.web3;


    this.sortOptions = [
      {label: 'Most Bets First', value: '!bets'},
      {label: 'Least Bets First', value: 'bets'}
    ];
    this.getBisonNames();
  }

  genderToString(age: number) {
    if(age === 1) {
      return "Male";
    }
    if(age === 0) {
      return "Female";
    }
  }



  findBisonOnBlockchainData() {
    for(let key in mapData) {
      for(let i in this.blockChainBisonNames) {



        if(this.blockChainBisonNames[i] == mapData[key].properties.name) {
          this.bisons.push({
            name: mapData[key].properties.name,
            age: mapData[key].properties.age,
            gender: mapData[key].properties.gender,
            maxDistance: mapData[key].properties['max distance traveled'],
            totalWins: mapData[key].properties['total wins']
          });
        }

      }

    }


    this.getAllBisonBets();
  }



  placeBet(bisonName: string) {
    this.web3Service.placeBet(bisonName);
  }

  onSortChange(event) {
    let value = event.value;

    if (value.indexOf('!') === 0) {
      this.sortOrder = -1;
      this.sortField = value.substring(1, value.length);
    }
    else {
      this.sortOrder = 1;
      this.sortField = value;
    }
  }

  async getBisonData() {
    let res = await this.web3Service.getBisonData();
  }

  async getBisonNames() {
    let res = await this.web3Service.getBisonNames();
    console.log(res);

    for(let i in res) {
      this.blockChainBisonNames.push(this.web3.utils.toAscii(res[i]).replace(/\0/g, ''));
    }

    this.findBisonOnBlockchainData();

  }

  async getAllBisonBets() {
    let res = await this.web3Service.totalBetsForAllBisons();


    console.log(res);


    this.bisons.forEach((val, index) => {
      this.bisons[index].bets = res[index];
    });

  }
}
