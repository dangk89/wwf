import { Component, OnInit } from '@angular/core';
import {Web3Service} from "../web3.service";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  constructor(private web3Service: Web3Service) { }

  ngOnInit() {
    this.web3Service.logAccounts();
    this.web3Service.getBisonData();
  }


  async getBisonData() {
    await this.web3Service.getBisonData()
  }




}
