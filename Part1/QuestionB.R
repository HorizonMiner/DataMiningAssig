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

## Third insight

library(reshape) # melt
library(Hmisc) # impute

movies <- read.csv("dataset/movie_metadata.csv", stringsAsFactors = FALSE)

## Step 1: Get directors with gross and molten genres
##
## First dataframe: directorWithGenres
## genres | director | gross
##

# Split genre into a vector of genres
print("Split genre into a vector of genres.")
movies$genres <- strsplit(movies$genres, "|", fixed = T)

# Melt genre
print("Melt genre.")
directorWithGenres <- melt(movies$genres)
colnames(directorWithGenres) <- c("genres", "director")

# Assign director name and gross to molten genre
print("Assign director name and gross to molten genre.")
directorWithGenres['gross'] <- as.numeric(0)
i <- 1
for (x in directorWithGenres$director){
  directorWithGenres$director[i] <- movies$director_name[x]
  directorWithGenres$gross[i] <- movies$gross[x]
  i <- i + 1
}

# Replace empty gross with 0 using imputation and remove rows with NAs
print("Replace empty gross with 0 using imputation and remove rows with NAs.")
directorWithGenres$gross <- impute(directorWithGenres$gross, 0)
directorWithGenres <- na.omit(directorWithGenres)

## Step 2: Get top 20 directors with highest gross, their top genre 
## (can be composite due to same highest frequency) and its frequency
##
## Second data frame: topDirector
## director | total gross | top genre | genre count
##

# Create a data frame with 4 columns: 
# director, total gross, top genre and genre count.
print("Create a data frame with 4 columns: director, total gross, top genre and genre count.")
topDirector <- data.frame(director = unique(directorWithGenres$director), total_gross = 0, top_genre = "", genre_count = 0, stringsAsFactors = F)

# Compute and assign total gross for each director
print("Compute and assign total gross for each director.")
i <- 1
for (name in topDirector$director){
  topDirector$total_gross[i] <- sum(directorWithGenres$gross[directorWithGenres$director == name])
  i <- i + 1
}

# Get the top 20 directors with the highest total gross
print("Get the top 20 directors with the highest total gross")
topDirector <- topDirector[order(-topDirector$total_gross),][1:20,]

# For each top 20 directors, assign genre with highest frequency and its frequency
print("For each top 20 directors, assign genre with highest frequency and its frequency.")
i <- 1
for (dir in topDirector$director){
  # Get a top 20 director with his/her genres 
  aDirectorWithGenres <- directorWithGenres[directorWithGenres$director == dir,]
  
  # Get genres with their frequency
  genreWithCount <- data.frame(table(aDirectorWithGenres$genres))
  
  # Get the genre with highest frequency
  maxGenreCount <- max(genreWithCount$Freq)
  genreWithMaxCount <- as.character(genreWithCount$Var1[genreWithCount$Freq == maxGenreCount])
  
  # When there are multiple genres with the same highest frequency, 
  # concatenate the genres
  if (length(genreWithMaxCount) > 1){
    concatGenre <- NULL
    for (genre in genreWithMaxCount){
      concatGenre <- paste(concatGenre, genre, sep = "|")
    }
    genreWithMaxCount <- substring(concatGenre, 2) # Remove | in first element
  }
  
  # Assign genre with highest frequency and its frequency to the data frame
  topDirector$top_genre[i] <- genreWithMaxCount 
  topDirector$genre_count[i] <- maxGenreCount
  i <- i + 1
}

## Step 3: Get mean gross for top genre
##
## Third data frame: meanGrossForGenre
## genre | director | genre count | mean gross
##

# Create a data frame with top 20 directors' genres
print("Create a data frame with top 20 directors' genres.")
meanGrossForGenre <- data.frame(genre = topDirector$top_genre,  stringsAsFactors = F)

# Split genre into a vector of genres
print("Split genre into a vector of genres.")
meanGrossForGenre$genre <- strsplit(meanGrossForGenre$genre, split = "|", fixed = T)

# Melt genre
print("Melt genre.")
meanGrossForGenre <- melt(meanGrossForGenre$genre)
colnames(meanGrossForGenre) <- c("genre", "director")

# Assign director and genre count
print("Assign director and genre count.")
meanGrossForGenre['genre_count'] <- as.numeric(0)
i <- 1
for (x in meanGrossForGenre$director){
  meanGrossForGenre$director[i] <- topDirector$director[x]
  meanGrossForGenre$genre_count[i] <- topDirector$genre_count[x]
  i <- i + 1
}

# Compute and assign mean gross
print("Compute and assign mean gross.")
meanGrossForGenre['mean_gross'] <- as.numeric(0)
for(i in 1:nrow(meanGrossForGenre)){
  # Subset by director and then by genre
  genreWithGross <- directorWithGenres[directorWithGenres$director == meanGrossForGenre$director[i],]  
  genreWithGross <- genreWithGross[genreWithGross$genres == as.character(meanGrossForGenre$genre[i]), ]
  
  meanGrossForGenre$mean_gross[i] <- mean(genreWithGross$gross)
}

## Step 4: Plot number of genres agaisnt genre count for top 20 profitable 
## directors
##

# Rearrange columns and round mean gross to zero decimal places.
print("Rearrange columns and round mean gross to zero decimal places.")
meanGrossForGenre <- meanGrossForGenre[,c(3,1,2,4)]
meanGrossForGenre$mean_gross <- round(meanGrossForGenre$mean_gross, 0)

# Plot of number of genres agaisnt genre count for top 20 profitable directors
print("Plot of number of genres agaisnt genre count for top 20 profitable directors.")
ggplot(meanGrossForGenre, aes(x = genre_count)) + 
  facet_wrap(~director + mean_gross, labeller = label_context) +
  geom_bar(aes(fill = genre)) +
  xlab("Counts of Movies' Genre") + 
  ylab("Genre's Number by Director") +
  ggtitle("Top 20 Profitable Director") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
# We may use this to 
# 1. Predict the next movie genre by the director
# 2. Predict the gross of the next movie by the director
# 3. Predict the popularity of the next movie by the director based on gross

## Fourth Insight

# Step 1： Create data frame with columns: actor 1's name, mean IMDB score and number of rating for actor 1
print("Create data frame with columns: actor 1's name, mean IMDB score and number of rating for actor 1.")
actorRating <- data.frame(actor_1 = unique(dataset$actor_1_name), mean_score = 0, num_of_rating = 0, stringsAsFactors = F)

# Step 2： Assign mean IMDB score and number of rating to each unique actor 1 accordingly
print("Assign mean IMDB score and number of rating to each unique actor 1 accordingly.")
i <- 1
for (name in actorRating$actor_1){
  actorRating$mean_score[i] = mean(dataset$imdb_score[dataset$actor_1_name == name], na.rm=T)
  actorRating$num_of_rating[i] = length(na.omit(dataset$imdb_score[dataset$actor_1_name == name]))
  i <- i + 1
}

# Step 3： Get actors wtih more than twenty movie participation
print("Get actors wtih more than twenty movie participation.")
topNumOfRating <- actorRating[actorRating$num_of_rating > 20, ]
topNumOfRating <- topNumOfRating[order(topNumOfRating$mean_score, decreasing = T), ]

# Step 4: Plot a bar chart to show mean rating for the actor 1 against actor 1's name
print("Plot a bar chart to show mean rating for the actor 1 against actor 1's name.")
library(ggplot2)
ggplot(topNumOfRating, aes(x = reorder(topNumOfRating$actor_1, -topNumOfRating$mean_score), y = topNumOfRating$mean_score)) + 
		geom_bar(stat = "identity", colour = rainbow(26)) + 
		theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
		ggtitle("Top Rated Actors with Movie Participated > 20") +
  		labs(x="Actor 1's Name",y="Mean Rating")

## Fifth insight

# Step 1： Create data frame with columns: directors' name, mean imdb score and number of rating for the director
print("Create data frame with columns: directors' name, mean imdb score and number of rating for the director.")
directorRating <- data.frame(director = unique(dataset$director_name), mean_score = 0, num_of_rating = 0, stringsAsFactors = F)

# Step 2： Assign mean IMDB score and number of rating to each unique director accordingly
print("Assign mean IMDB score and number of rating to each unique director accordingly.")
i <- 1
for (name in directorRating$director){
  directorRating$mean_score[i] = mean(dataset$imdb_score[dataset$director_name == name], na.rm=T)
  directorRating$num_of_rating[i] = length(na.omit(dataset$imdb_score[dataset$director_name == name]))
  i <- i + 1
}

# Step 3： Get top 20 directors with most movie made
print("Get top 20 directors with most movie made.")
topNumOfDirRating <- directorRating[1:20, ]
topNumOfDirRating <- topNumOfDirRating[order(topNumOfDirRating$mean_score, decreasing = T), ]

# Step 4: Plot a bar chart of mean rating for the director against directors's name
print("Plot a bar chart of mean rating for the director against directors's name.")
library(ggplot2)
ggplot(topNumOfDirRating, aes(x = reorder(topNumOfDirRating$director, -topNumOfDirRating$mean_score), y = topNumOfDirRating$mean_score)) + 
		geom_bar(stat = "identity", colour = rainbow(20)) + 
		theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
		ggtitle("Top 20 Most Movies Made Director") +
  		labs(x="Directors' Name",y="Mean Rating")