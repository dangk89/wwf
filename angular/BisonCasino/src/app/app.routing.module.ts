import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {HomeComponent} from "./home/home.component";
import {MapComponent} from "./map/map.component";
import {NewsComponent} from "./news/news.component";
import {AboutComponent} from "./about/about.component";

// Routes for the components. This sets the URL paths for where they are found.
const appRoutes: Routes = [
  // Auth routes
  { path: '', component: HomeComponent},
  { path: 'map', component: MapComponent},
  { path: 'news', component: NewsComponent},
  { path: 'about', component: AboutComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(appRoutes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
