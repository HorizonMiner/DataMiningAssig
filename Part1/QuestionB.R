# Question B - Possible Insights

# Load dataset
dataset <- read.csv("dataset/movie_metadata.csv")

## First insight

# Plot of facebook likes agaisnt year:
print("Plot of facebook likes agaisnt year:")

plot(x = dataset$title_year, y = dataset$movie_facebook_likes, xlab = "Year", ylab = "Facebook Likes", main = "Facebook Likes against Year", type = "l")
# This plot shows that older movies clearly have less facebook likes
# and recent movies have the most facebook likes.