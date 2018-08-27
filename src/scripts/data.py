import pandas as pd
import random
import json
from collections import OrderedDict
from string_to_bytes32 import string_to_bytes32

# Example of daily stats format
d = ['bison','travel_distance','max_alt','max_temp']
df = pd.DataFrame(columns=d)
for i in range(100):
  df.loc[i] = ['bison'+str(i), random.randint(1800,9100),random.randint(525,2038), random.randint(-16,49)]


# Creating mapdata in .js format
namelist = ["Glady", "Seema", "Latanya", "Adelaide", "Tennille", "Evon", "Douglass", "Sheryl", "Lizbeth", "Melodi", "Rosana", "Sherlene", "Brenna", "Aja", "Susie", "Aurea", "Nathalie", "Quinton", "Thomas", "Kellee", "Alta", "Alonzo", "Derick", "Kip", "Hailey", "Hye", "Lue", "Lilla", "Pok", "Clark", "Julene", "Francesca", "Sachiko", "Trista", "Brook", "Verdell", "Shonna", "Loyce", "Rona", "Willia", "Denny", "Bebe", "Vella", "Chance", "Wilhemina", "Brandie", "Marcel", "Yong", "Tenisha", "Jacquiline"]



mapdata = OrderedDict()
for i in range(50):
	mapdata["b"+str(i)]= OrderedDict([("type", "Feature"),("properties",OrderedDict([("name",namelist[i]),("gender", random.randint(0,1)), ("age", random.randint(0,20)), ("distance", random.randint(3000,8500)),("max distance traveled", random.randint(6000,9100)), ("total wins", random.randint(0,2)),("image","img/bison.png"),("iconSize",[30,30]),("url","index.html")])),("geometry", OrderedDict([("type", "Point"),("coordinates", [random.uniform(22.35131, 22.535629999999998),random.uniform(45.153040000000004, 45.28548)])]))])



# Create new constructor input
"""
json_data = json.loads(open('mapdata.js').read(), object_pairs_hook=OrderedDict)
bisonNames = [string_to_bytes32(mapdata[bison]["properties"]["name"]) for bison in mapdata]
bisonData = [mapdata[bison]["properties"]["distance"] for bison in mapdata]


#Save mapdata and bison_data
with open("mapdata.js", 'w') as f:
        json.dump(mapdata, f)

df.to_csv("bison_data.csv" ,  index = False)
"""

# Create constructor input from mapdata file
json_data = json.loads(open('mapdata.js').read(), object_pairs_hook=OrderedDict)
bisonNames = [string_to_bytes32(json_data[bison]["properties"]["name"]) for bison in json_data]
bisonData = [json_data[bison]["properties"]["distance"] for bison in json_data]


# Print bison names and data
output = str(bisonNames) +','+ str(bisonData)
output = output.replace('\'', '"')
print(output)
