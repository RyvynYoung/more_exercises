import matplotlib.pyplot as plt

x_values = range(1, 6)
y_values = [x**3 for x in x_values]

fig, ax = plt.subplots()
ax.scatter(x_values, y_values, s=100)

# Set chart title and labels
ax.set_title("Cubed Numbers", fontsize=14)
ax.set_xlabel("Value", fontsize=10)
ax.set_ylabel("Cube of Value", fontsize=10)

ax.tick_params(axis='both', which='major', labelsize=8)

plt.show()

