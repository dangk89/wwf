import pandas as pd
import random 

d = ['bison','travel_distance','max_alt','max_temp']
df = pd.DataFrame(columns=d)

for i in range(100):
  df.loc[i] = ['bison'+str(i), random.randint(1800,9100),random.randint(525,2038), random.randint(-16,49)]

print(df)

df.to_csv("bison_data.csv" ,  index = False)
