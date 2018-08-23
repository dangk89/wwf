import pandas as pd
import random 
import names 
import json
from collections import OrderedDict

d = ['bison','travel_distance','max_alt','max_temp']
df = pd.DataFrame(columns=d)

for i in range(100):
  df.loc[i] = ['bison'+str(i), random.randint(1800,9100),random.randint(525,2038), random.randint(-16,49)]



d2 = ['bison','image_loc','coordinates']
df2 = pd.DataFrame(columns=d2)

for i in range(100):
  df2.loc[i] = [names.get_last_name(), "img/bison.png", (random.uniform(22.35131, 22.535629999999998),random.uniform(45.153040000000004, 45.28548))]


mapdata = OrderedDict()
for i in range(100):
	#mapdata["b"+str(i)]= {"type": "Feature", "properties" : {"name" : names.get_last_name(), "image" : "img/bison.png", "iconSize" : [30,30], "url" : "index.html"}, "geometry": {"type" : "Point"}, "coordinates" : [random.uniform(45.153040000000004, 45.28548), random.uniform(22.35131, 22.535629999999998)]}
	mapdata["b"+str(i)]= OrderedDict([("type", "Feature"),("properties",OrderedDict([("name",names.get_last_name()),("image","img/bison.png"),("iconSize",[30,30]),("url","index.html")])),
("geometry", OrderedDict([("type", "Point"),("coordinates", [random.uniform(22.35131, 22.535629999999998),random.uniform(45.153040000000004, 45.28548)])]))])




with open("mapdata.js", 'w') as f:
        json.dump(mapdata, f)





"""
var mapdata = {

    bison: {
        "type": "Feature",
        "properties": {
            "name": "Gunni"
            "image": "img/bison.png",
            "iconSize": [30, 30],
            "url": "index.html"
        },
        "geometry": {
            "type": "Point",
            "coordinates": [
                12.533615,
                55.675353
            ]
        }
    }
  };

"""


#print(df2)










#df.to_csv("bison_data.csv" ,  index = False)
