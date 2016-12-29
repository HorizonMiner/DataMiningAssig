# Question B - Possible Insights

# Load dataset
dataset <- read.csv("dataset/movie_metadata.csv")

## First insight

# Plot of facebook likes agaisnt year:
print("Plot of facebook likes agaisnt year:")

plot(x = dataset$title_year, y = dataset$movie_facebook_likes, xlab = "Year", ylab = "Facebook Likes", main = "Facebook Likes against Year", type = "l")
# This plot shows that older movies clearly have less facebook likes
# and recent movies have the most facebook likes.

## Second insight

# Mean of standard deviation of IMDB score with respect to director
print("Mean of standard deviation of IMDB score with respect to director:")

# Step 1: Create empty data frame with two columns
directorWithSD <- data.frame(director = character(), standard_deviation = numeric())

# Step 2: Calculate standard deviation of IMDB score for each director
for (director in unique(dataset$director_name)) {
  standardDeviation <- sd(dataset$imdb_score[dataset$director_name == director])
  
  # Append to data frame
  directorWithSD <- rbind(directorWithSD, data.frame(director = director, standard_deviation = standardDeviation))
}

# Step 3: Calculate mean of standard deviation column
mean(directorWithSD$standard_deviation, na.rm = TRUE) # yields 0.636415
# This shows that directors are consistent since their standard deviation of 
# IMDB score on average is not more than 1.