import json
from plotly.graph_objs import Scattergeo, Layout
from plotly import offline

# Explore the structure of the data
filename =  'codeup-data-science/more_exercises/pcc_ch16/eq_data_30_day_m1.json'
with open(filename) as f:
    all_eq_data = json.load(f)

# readable_file = 'codeup-data-science/more_exercises/pcc_ch16/readable_eq_data.json'
# with open(readable_file, 'w') as f:
#     json.dump(all_eq_data, f, indent=4)

# get a list that contains all of the information about every earthquake that occurred
all_eq_dicts = all_eq_data['features']
# print(len(all_eq_dicts))

# extract magnitudes and location for each earthquake
# refactored code
mags, lons, lats, hover_texts = [], [], [], []
mags = [eq_dict['properties']['mag'] for eq_dict in all_eq_dicts]
lons = [eq_dict['geometry']['coordinates'][0] for eq_dict in all_eq_dicts]
lats = [eq_dict['geometry']['coordinates'][1] for eq_dict in all_eq_dicts]
hover_texts = [eq_dict['properties']['title'] for eq_dict in all_eq_dicts]

# original code
# for eq_dict in all_eq_dicts:
#     mag = eq_dict['properties']['mag']
#     lon = eq_dict['geometry']['coordinates'][0]
#     lat = eq_dict['geometry']['coordinates'][1]
#     title = eq_dict['properties']['title']
#     mags.append(mag)
#     lons.append(lon)
#     lats.append(lat)
#     hover_texts.append(title)
# print(mags[:10])
# print(lons[:5])
# print(lats[:5])

# Map the earthquakes
data = [{
    'type': 'scattergeo', 
    'lon':lons, 
    'lat':lats,
    'text': hover_texts,
    'marker': {
        'size': [3*mag for mag in mags],
        'color': mags,
        'colorscale': 'Viridis',
        'reversescale': True,
        'colorbar': {'title': 'Magnitude'},
    },
    }]
my_layout = Layout(title='Global Earthquakes')

fig = {'data': data, 'layout': my_layout}
offline.plot(fig, filename='global_earthquakes.html')



