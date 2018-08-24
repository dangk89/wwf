import { Component, OnInit } from '@angular/core';
import {Web3Service} from "../web3.service";
import {SelectItem} from "primeng/api";
import {mapData} from "../../assets/mapdata";
import Web3 from "web3";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  web3: Web3;
  blockChainBisonNames = [];
  bisons = [];
  sortOptions: SelectItem[];
  sortKey: string;
  sortField: string;
  sortOrder: number;


  constructor(private web3Service: Web3Service) { }

  ngOnInit() {
    this.web3 = new Web3('penis');
    console.log(mapData);


    for(let key in mapData) {
      console.log(mapData[key].properties.name);
      this.bisons.push({
        name: mapData[key].properties.name,
        age: mapData[key].properties.age,
        gender: mapData[key].properties.gender,
        maxDistance: mapData[key].properties['max distance traveled'],
        totalWins: mapData[key].properties['total wins']
      });
    }



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

  }



  placeBet() {

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

    for(let bytes32 in res) {
      this.blockChainBisonNames.push(this.web3.toAscii(bytes32))
    }




    console.log(this.blockChainBisonNames);
  }




}
