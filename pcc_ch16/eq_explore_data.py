import json
from plotly.graph_objs import Scattergeo, Layout
from plotly import offline

# Explore the structure of the data
filename =  'codeup-data-science/more_exercises/pcc_ch16/eq_data_1_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

# readable_file = 'codeup-data-science/more_exercises/pcc_ch16/readable_eq_data.json'
# with open(readable_file, 'w') as f:
#     json.dump(all_eq_data, f, indent=4)

# get a list that contains all of the information about every earthquake that occurred
all_eq_dicts = all_eq_data['features']
# print(len(all_eq_dicts))

# extract magnitudes and location for each earthquake
mags, lons, lats = [], [], []
for eq_dict in all_eq_dicts:
    mag = eq_dict['properties']['mag']
    lon = eq_dict['geometry']['coordinates'][0]
    lat = eq_dict['geometry']['coordinates'][1]
    mags.append(mag)
    lons.append(lon)
    lats.append(lat)
# print(mags[:10])
# print(lons[:5])
# print(lats[:5])

# Map the earthquakes
data = [{
    'type': 'scattergeo', 
    'lon':lons, 
    'lat':lats
    }]
my_layout = Layout(title='Global Earthquakes')

fig = {'data': data, 'layout': my_layout}
offline.plot(fig, filename='global_earthquakes.html')



