# import the csv module
import csv
# import matplotlib for visualization
import matplotlib.pyplot as plt
from datetime import datetime

# use full path filename to access file (relative path does not work in vscode)
filename = 'codeup-data-science/more_exercises/pcc_ch16/death_valley_2018_simple.csv'
# open the file as a file object
with open(filename) as f:
    # call the reader function and pass it the file object as an argument
    reader = csv.reader(f)
    # use the next function one time to retrive just the first line of the file and store as header_row
    header_row = next(reader)

    # print the index and value of header in the header_row 
    # enumerate() function returns both the index of each item and the value of each item as you loop through a list
    # for index, column_header in enumerate(header_row):
    #     print(index, column_header)
    
    # Get dates and high and low temperatures from this file
    dates, highs, lows = [], [], []
    for row in reader:
        current_date = datetime.strptime(row[2], "%Y-%m-%d")
        try:
            high = int(row[4])
            low = int(row[5])
        except ValueError:
            print(f"Missing data for {current_date}")
        else:
            dates.append(current_date)
            highs.append(high)
            lows.append(low)
            
    # Plot the high temperatures
    plt.style.use('seaborn')
    fig, ax = plt.subplots()
    ax.plot(dates, highs, c='red', alpha=0.5)
    ax.plot(dates, lows, c='blue', alpha=0.5)
    # use fill_between method to fill area between the high and the low temps
    plt.fill_between(dates, highs, lows, facecolor='green', alpha=0.1)

    # Format plot
    title = "Daily high and low temperatures - 2018\Death Valley, CA"
    plt.title(title, fontsize=20)
    plt.xlabel("", fontsize=16)
    fig.autofmt_xdate()
    plt.ylabel("Temperature(F)", fontsize=16)
    plt.tick_params(axis='both', which='major', labelsize=16)

    plt.show()