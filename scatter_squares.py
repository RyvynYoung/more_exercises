import matplotlib.pyplot as plt

x_values = range(1, 1001)
y_values = [x**2 for x in x_values]

plt.style.use('seaborn')
fig, ax = plt.subplots()
ax.scatter(x_values, y_values, c=y_values, cmap=plt.cm.Blues, s=10)
# currently using color map for color values
# can use c='red' to designate color of dots, or
# can also use c=(0, 0.8, 0) to use RBG color model- red, green, blue
# values between 0 and 1, closer to 0 = darker, closer to 1 = lighter

# Set chart title and label axes
ax.set_title("Square Numbers", fontsize=24)
ax.set_xlabel("Value", fontsize=14)
ax.set_ylabel("Square of Value", fontsize=14)

# Set range of each axis
ax.axis([0, 1100, 0, 1100000])

plt.show()
# to automatically save the plot to a file use this instead of plot.show()
# plt.savefig('squares_plot.png', bbox_inches='tight')

# bbox_inches='tight' trims the whitespace around the plot, to keep whitespace omit this argument
