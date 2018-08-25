import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import {Web3Service} from "./web3.service";
import { AboutComponent } from './about/about.component';
import { MapComponent } from './map/map.component';
import { NewsComponent } from './news/news.component';
import {AppRoutingModule} from "./app.routing.module";
import {DataViewModule} from "primeng/dataview";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {PanelModule} from "primeng/panel";
import {DropdownModule} from "primeng/primeng";
import {FormsModule} from "@angular/forms";
import {GMapModule} from "primeng/gmap";

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    AboutComponent,
    MapComponent,
    NewsComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    AppRoutingModule,
    DataViewModule,
    PanelModule,
    DropdownModule,
    FormsModule,
    GMapModule
  ],
  providers: [
    Web3Service
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
