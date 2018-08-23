import pandas as pd
import random 
import names 
import json
from collections import OrderedDict


# Example of daily stats format 
d = ['bison','travel_distance','max_alt','max_temp']
df = pd.DataFrame(columns=d)
for i in range(100):
  df.loc[i] = ['bison'+str(i), random.randint(1800,9100),random.randint(525,2038), random.randint(-16,49)]


# Creating mapdata in .js format 
mapdata = OrderedDict()
for i in range(100):
	#mapdata["b"+str(i)]= {"type": "Feature", "properties" : {"name" : names.get_last_name(), "image" : "img/bison.png", "iconSize" : [30,30], "url" : "index.html"}, "geometry": {"type" : "Point"}, "coordinates" : [random.uniform(45.153040000000004, 45.28548), random.uniform(22.35131, 22.535629999999998)]}
	mapdata["b"+str(i)]= OrderedDict([("type", "Feature"),("properties",OrderedDict([("name",names.get_last_name()),("gender", random.randint(0,1)), ("age", random.randint(0,20)), ("max distance traveled", random.randint(6000,9100)), ("total wins", random.randint(0,2)),("image","img/bison.png"),("iconSize",[30,30]),("url","index.html")])),("geometry", OrderedDict([("type", "Point"),("coordinates", [random.uniform(22.35131, 22.535629999999998),random.uniform(45.153040000000004, 45.28548)])]))])


# Save
with open("mapdata.js", 'w') as f:
        json.dump(mapdata, f)

df.to_csv("bison_data.csv" ,  index = False)







