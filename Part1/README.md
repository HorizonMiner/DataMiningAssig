# Group Members
1. Khor Kia Kin 1142701883
2. Ng Chin Ann 1142701684
3. Kirthivaasan Puniamurthy 1142702268
4. Ng Chen Hon 1132702936

# Setup
1. To load dataset:

    ```r
dataset <- read.csv("dataset/movie_metadata.csv")
    ```

# A. Description of Dataset

1. This dataset is scraped from 5000+ movies on IMDB to obtain the insight of how great a movie without relying on human critics and human instinct or whether its based on the number of faces in movie poster.

2. This dataset has 5043 observations and 28 variables.
    ```r
dim(dataset)
    ```

    ```
## [1] 5043   28
    ```

3. This dataset has 28 variables, which are `color`, `director_name`, `num_critic_for_reviews`, `duration`, `director_facebook_likes`, `actor_3_facebook_likes`, `actor_2_name`, `actor_1_facebook_likes`, `gross`, `genres`, `actor_1_name`, `movie_title`, `num_voted_users`, `cast_total_facebook_likes`, `actor_3_name`, `facenumber_in_poster`, `plot_keywords`, `movie_imdb_link`, `num_user_for_reviews`, `language`, `country`, `content_rating`, `budget`, `title_year`, `actor_2_facebook_likes`, `imdb_score`, `aspect_ratio` and `movie_facebook_likes`.

    ```r
names(dataset)
    ```

    ```
##  [1] "color"                     "director_name"            
##  [3] "num_critic_for_reviews"    "duration"                 
##  [5] "director_facebook_likes"   "actor_3_facebook_likes"   
##  [7] "actor_2_name"              "actor_1_facebook_likes"   
##  [9] "gross"                     "genres"                   
## [11] "actor_1_name"              "movie_title"              
## [13] "num_voted_users"           "cast_total_facebook_likes"
## [15] "actor_3_name"              "facenumber_in_poster"     
## [17] "plot_keywords"             "movie_imdb_link"          
## [19] "num_user_for_reviews"      "language"                 
## [21] "country"                   "content_rating"           
## [23] "budget"                    "title_year"               
## [25] "actor_2_facebook_likes"    "imdb_score"               
## [27] "aspect_ratio"              "movie_facebook_likes"
    ```

# B. Possible Insights
1. First Insight. Plot of facebook likes agaisnt year:

    ```
plot(x = dataset$title_year, y = dataset$movie_facebook_likes, 
xlab = "Year", ylab = "Facebook Likes", main = "Facebook Likes against Year", type = "l")
    ```

    ![Facebook Likes Against Year](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part1/images/FbLikesAgainstYear.png)

    This plot shows that older movies clearly have less facebook likes and recent movies have the most facebook likes.

2. Second Insight. 
    Mean of standard deviation of IMDB score with respect to director: 

    ```
# Step 1: Create empty data frame with two columns
directorWithSD <- data.frame(director = character(), standard_deviation = numeric())

# Step 2: Calculate standard deviation of IMDB score for each director
for (director in unique(dataset$director_name)) {
  standardDeviation <- sd(dataset$imdb_score[dataset$director_name == director])
  
  # Append to data frame
  directorWithSD <- rbind(directorWithSD, data.frame(director = director, standard_deviation = standardDeviation))
}

# Step 3: Calculate mean of standard deviation column
mean(directorWithSD$standard_deviation, na.rm = TRUE) 
    ```

    ```
## [1] 0.636415
    ```

    This shows that directors are consistent since their standard deviation of IMDB score on average is not more than 1.

3. Third Insight.
    ```
library(reshape) # melt
library(Hmisc) # impute

movies <- read.csv("dataset/movie_metadata.csv", stringsAsFactors = FALSE)
    ```

   * Step 1: Get directors with gross and molten genres.

    First dataframe: `directorWithGenres`.

    Its variables: `genres`, `director`, and `gross`.

   * 1a: Split genre into a vector of genres

    ```r
movies$genres <- strsplit(movies$genres, "|", fixed = T)
    ```

   * 1b: Melt genre

    ```
directorWithGenres <- melt(movies$genres)
colnames(directorWithGenres) <- c("genres", "director")
    ```

   * 1c: Assign director name and gross to molten genre

    ```
directorWithGenres['gross'] <- as.numeric(0)
i <- 1
for (x in directorWithGenres$director){
  directorWithGenres$director[i] <- movies$director_name[x]
  directorWithGenres$gross[i] <- movies$gross[x]
  i <- i + 1
}
    ```


   * 1d: Replace empty gross with 0 using imputation and remove rows with NAs
    ```r
directorWithGenres$gross <- impute(directorWithGenres$gross, 0)
directorWithGenres <- na.omit(directorWithGenres)
    ```

   * Step 2: Get top 20 directors with highest gross, their top genre (can be composite due to same highest frequency) and its frequency

    Second data frame: `topDirector`.

    Its variables: `director`, `total gross`, `top genre`, and `genre count`.

   * 2a: Create a data frame with 4 columns: `director`, `total gross`, `top genre`, and `genre count`.

    ```r
topDirector <- data.frame(director = unique(directorWithGenres$director), total_gross = 0, top_genre = "", genre_count = 0, stringsAsFactors = F)
    ```

   * 2b: Compute and assign total gross for each director

    ```r
i <- 1
for (name in topDirector$director){
  topDirector$total_gross[i] <- sum(directorWithGenres$gross[directorWithGenres$director == name])
  i <- i + 1
}
    ```

   * 2c: Get the top 20 directors with the highest total gross

    ```r
topDirector <- topDirector[order(-topDirector$total_gross),][1:20,]
    ```

   * 2d: For each top 20 directors, assign genre with highest frequency and its frequency

    ```r
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
    ```

   * Step 3: Get mean gross for top genre

    Third data frame: `meanGrossForGenre`.

    Its variables: `genre`, `director`, `genre count` and `mean gross`.

   * 3a: Create a data frame with top 20 directors' genres
    
    ```r
meanGrossForGenre <- data.frame(genre = topDirector$top_genre,  stringsAsFactors = F)
    ```

   * 3b: Split genre into a vector of genres

    ```r
meanGrossForGenre$genre <- strsplit(meanGrossForGenre$genre, split = "|", fixed = T)
    ```

   * 3c: Melt genre

    ```r
meanGrossForGenre <- melt(meanGrossForGenre$genre)
colnames(meanGrossForGenre) <- c("genre", "director")
    ```

   * 3d: Assign director and genre count

    ```r
meanGrossForGenre['genre_count'] <- as.numeric(0)
i <- 1
for (x in meanGrossForGenre$director){
  meanGrossForGenre$director[i] <- topDirector$director[x]
  meanGrossForGenre$genre_count[i] <- topDirector$genre_count[x]
  i <- i + 1
}
    ```

   * 3e: Compute and assign mean gross

    ```r
meanGrossForGenre['mean_gross'] <- as.numeric(0)
for(i in 1:nrow(meanGrossForGenre)){
  # Subset by director and then by genre
  genreWithGross <- directorWithGenres[directorWithGenres$director == meanGrossForGenre$director[i],]  
  genreWithGross <- genreWithGross[genreWithGross$genres == as.character(meanGrossForGenre$genre[i]), ]
  
  meanGrossForGenre$mean_gross[i] <- mean(genreWithGross$gross)
}
    ```

   * Step 4: Plot number of genres agaisnt genre count for top 20 profitable directors

   * 4a: Rearrange columns and round mean gross to zero decimal places.

    ```r
meanGrossForGenre <- meanGrossForGenre[,c(3,1,2,4)]
meanGrossForGenre$mean_gross <- round(meanGrossForGenre$mean_gross, 0)
    ```

   * 4b: Plot of number of genres agaisnt genre count for top 20 profitable directors

    ```
ggplot(meanGrossForGenre, aes(x = genre_count)) + 
  facet_wrap(~director + mean_gross, labeller = label_context) +
  geom_bar(aes(fill = genre)) +
  xlab("Counts of Movies' Genre") + 
  ylab("Genre's Number by Director") +
  ggtitle("Top 20 Profitable Director") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
    ```

    ![Top 20 Profitable Directors](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part1/images/Top20ProfitableDirector.png)

   * We may use this to (1) predict the next movie genre by the director, (2) predict the gross of the next movie by the director and (3) predict the popularity of the next movie by the director based on gross

4. Fourth Insight.

   *  Step 1： Create data frame with columns: actor 1's name, mean IMDB score and number of rating for actor 1

    ```r
actorRating <- data.frame(actor_1 = unique(dataset$actor_1_name), mean_score = 0, num_of_rating = 0, stringsAsFactors = F)
    ```

   *  Step 2： Assign mean IMDB score and number of rating to each unique actor 1 accordingly

    ```r
i <- 1
for (name in actorRating$actor_1){
  actorRating$mean_score[i] = mean(dataset$imdb_score[dataset$actor_1_name == name], na.rm=T)
  actorRating$num_of_rating[i] = length(na.omit(dataset$imdb_score[dataset$actor_1_name == name]))
  i <- i + 1
}
    ```

   *  Step 3： Get actors wtih more than twenty movie participation

    ```r
topNumOfRating <- actorRating[actorRating$num_of_rating > 20, ]
topNumOfRating <- topNumOfRating[order(topNumOfRating$mean_score, decreasing = T), ]
    ```

   *  Step 4: Plot a bar chart to show mean rating for the actor 1 against actor 1's name
    
    ```r
library(ggplot2)
ggplot(topNumOfRating, aes(x = reorder(topNumOfRating$actor_1, -topNumOfRating$mean_score), y = topNumOfRating$mean_score)) + 
		geom_bar(stat = "identity", colour = rainbow(26)) + 
		theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
		ggtitle("Top Rated Actors with Movie Participated > 20") +
  		labs(x="Actor 1's Name",y="Mean Rating")
    ```
   ![Rating Against Actor 1](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part1/images/RatingAgainstActor1.png)

   *  Based on the plot we can (1) predict the rating for the next movie by the actor 1 and (2) studio or director can employ actor with good performance based on their rating to make better profit for their own.

5. Fifth Insight.

   *  Step 1： Create data frame with columns: directors' name, mean imdb score and number of rating for the director

    ```r
directorRating <- data.frame(director = unique(dataset$director_name), mean_score = 0, num_of_rating = 0, stringsAsFactors = F)
    ```

   *  Step 2： Assign mean IMDB score and number of rating to each unique director accordingly
	
	```r
i <- 1
for (name in directorRating$director){
  directorRating$mean_score[i] = mean(dataset$imdb_score[dataset$director_name == name], na.rm=T)
  directorRating$num_of_rating[i] = length(na.omit(dataset$imdb_score[dataset$director_name == name]))
  i <- i + 1
}
	```

   *  Step 3： Get top 20 directors with most movie made

	```r
topNumOfDirRating <- directorRating[1:20, ]
topNumOfDirRating <- topNumOfDirRating[order(topNumOfDirRating$mean_score, decreasing = T), ]
	```

   *  Step 4: Plot a bar chart of mean rating for the director against directors's name

	```r
library(ggplot2)
ggplot(topNumOfDirRating, aes(x = reorder(topNumOfDirRating$director, -topNumOfDirRating$mean_score), y = topNumOfDirRating$mean_score)) + 
		geom_bar(stat = "identity", colour = rainbow(20)) + 
		theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
		ggtitle("Top 20 Most Movies Made Director") +
  		labs(x="Directors' Name",y="Mean Rating")
	```

	![Rating Against Director](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part1/images/RatingAgainstDirector.png)

   *  Based on the plot, we can predict the rating and quality of the next movie by the director. Also, audience can spend smartly on the movie based on the prediction since they will have more confident on the coming movie.

# C. Relevant Data Mining Techniques
1. In order to find movies with similar plot and genre, a clustering algorithm can be used, such as k-nearest neighbours and k-means. Clustering is suitable for finding similar plot, since our data set contains a plot_keywords feature, which provides keywords related to the story of the movie. Similar words are best represented with a clustering algorithm. This can be used in a recommendation system.

2. For predicting whether a given movie is of a certain category or not, a classification algorithm can be used, such as decision tree.

3. Association rule mining technique can be used to determine the kind of movie that a director will most likely make next given the most frequent genre of movie that the director makes.

# D. Data Quality Issues

1. There are NAs in the dataset.
    * Number of NAs:

    ```r
sum(is.na(dataset))
    ```

    ```
## [1] 2059
    ```

2. There are empty values in observations.
   * Number of empty cells:

    ```r
# Check whether the cell is empty
isCellEmpty = function(cell)
{
    as.character(cell) == ""
}

# Calculate number of empty cells with no values
numEmptyCellsInDataFrame = function(dataFrame)
{
    boolVec = as.vector(apply(dataFrame, 2, isCellEmpty))
    unname(summary(boolVec)["TRUE"])
}

numEmptyCellsInDataFrame(dataset)
    ```

    ```
## [1] 639
    ```

3. All movie titles are delimited with a non-ascii character.
    * Movie title for the first ten rows in this dataset:

    ```r
dataset$movie_title[1:10]
    ```

    ```
##  [1] AvatarÂ                                                 
##  [2] Pirates of the Caribbean: At World's EndÂ               
##  [3] SpectreÂ                                                
##  [4] The Dark Knight RisesÂ                                  
##  [5] Star Wars: Episode VII - The Force AwakensÂ             
##  [6] John CarterÂ                                            
##  [7] Spider-Man 3Â                                           
##  [8] TangledÂ                                                
##  [9] Avengers: Age of UltronÂ                                
## [10] Harry Potter and the Half-Blood PrinceÂ
    ```

4. There are composite words in keyword and genre.
    * Genres and plot keywords for the first four rows in this dataset:

    ```r
dataset[1:4, c("genres", "plot_keywords")]
    ```

    ```
##                            genres                                                    plot_keywords
## 1 Action|Adventure|Fantasy|Sci-Fi                           avatar|future|marine|native|paraplegic
## 2        Action|Adventure|Fantasy     goddess|marriage ceremony|marriage proposal|pirate|singapore
## 3       Action|Adventure|Thriller                              bomb|espionage|sequel|spy|terrorist
## 4                 Action|Thriller deception|imprisonment|lawlessness|police officer|terrorist plot 
    ```

5. There are duplicates in the dataset.
    * Number of duplicates:

    ```r
sum(duplicated(dataset))
    ```

    ```
## [1] 45
    ```

6. There are duplicate movie titles. However, it cannot be removed completely since there may be different directors with the same movie title or different number of user votes.

    * Number of duplicate movie titles:

    ```
sum(duplicated(dataset$movie_title))
    ```
    ```
## [1] 126
    ```

    * Number of duplicate movie titles with director:

    ```r
sum(duplicated(dataset[,c("movie_title", "director_name")]))
    ```

    ```
## [1] 124
    ```

    This shows us that there are 2 movies with the same title but with different directors.

    * Number of duplicate movie titles with number of voted users:
    ```
sum(duplicated(dataset[,c("movie_title", "num_voted_users")])) # yields 47
    ```

    ```
## [1] 47
    ```

    This shows us there are 79 movies with the same title but with different number of votes.

7. Column order in dataset is random. 
    * Sixth variable to eighth variable:

    ```
names(dataset)[6:8]
    ```

    ```
## [1] "actor_3_facebook_likes" "actor_2_name" "actor_1_facebook_likes"
    ```

This shows that column order is random.

# E. Data Pre-processing
1. There are empty values in observations.
    * Solution: Replace empty columns with NAs.

    ```r
dataset[dataset == ''] <- NA
    ```

2. All movie titles are delimited with a non-ascii character.
    * Solution: Replace the non-ascii character with empty character.

    ```r
cleanTitle <- function(movie_name){
  movie_name <- sub('Â', '', movie_name)
}
dataset$movie_title <- sapply(dataset$movie_title, FUN = cleanTitle)
    ```

3. There are duplicates in the dataset.
    * Solution: Remove duplicated rows.

    ```r
dataset <- unique.data.frame(dataset)
    ```

4. There are duplicate movie titles.
    * Solution: Remove duplicated movie titles with different directors.

    ```r
exclude <- duplicated(dataset[ ,c("movie_title", "director_name")], fromLast = F)
dataset <- dataset[!exclude, ]
    ```

5. There are NAs in the dataset.
    * Solution: We cannot simply remove the rows with NAs because other columns still contain important information. For duration column, we can apply imputation. Since duration is MCAR, we use median for the imputation.

    ```r
library(Hmisc)
library(ggplot2)
    ```

    * Plot of duration (in minute) agaisnt gross (in million)

    ```r
ggplot(dataset, aes(x = dataset$gross/1000000, y = dataset$duration)) + 
  geom_point(alpha = 1/10) +
  labs(title = "Gross and Duration for Movies", y = "Duration (minute)", x = "Gross (million)") +
  theme_bw() 
    ```

    ![Duration Agaisnt Gross](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part1/images/DurationAgainstGross.png)

    This plot shows that gross has no effect on duration.

    * Plot of duration (in minute) agaisnt budget (in million)

    ```r
ggplot(dataset, aes(x = dataset$duration, y = dataset$budget/1000000)) + 
  geom_point(alpha = 1/10) +
  labs(title = "Budget and Duration for Movies", y = "Duration (minute)", x = "Budget (million)") +
  theme_bw() 
    ```

    ![Duration Agaisnt Budget](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part1/images/DurationAgainstBudget.png)

    This plot shows that budget has no effect on duration.

    * Since gross and budget have no effect on duration, we can apply median imputation to duration column.

    ```r
dataset$duration <- impute(dataset$duration, median)
    ```

    * Number of imputed observations:

    ```r
sum(is.imputed(dataset$duration))
    ```

    ```
    [1] 15
    ```

6. There are composite words in keyword and genre.
    * Solution: Melt genre
    
    ```r
library(reshape)

movies <- read.csv("dataset/movie_metadata.csv", stringsAsFactors = FALSE)
    ```

    * Split genre into a vector of genres

    ```r
movies$genres <- strsplit(movies$genres, "|", fixed = TRUE)
    ```

    * Melt genre
    ```r
directorWithGenres <- melt(movies$genres)
colnames(directorWithGenres) <- c("genres", "director")
    ```

    * Assign director name to molten genre
    ```r
i <- 1
for (x in directorWithGenres$director){
  directorWithGenres$director[i] <- movies$director_name[x]
  i <- i + 1
}
    ```

7. Column order in dataset is random.
    * Solution: Rearrange column order in dataset.
    ```r
dataset <- dataset[, c(12,28,2,5,22,10,17,24,3,13,19,26,20,21,23,9,27,1,4,11,8,7,25,15,6,14,16,18)]
    ```

    * Save the arranged dataset to a csv file.
    ```r
write.csv(dataset, file="rearrangedDf.csv")
    ```

# Reference
[IMDB 5000 Movie Dataset](https://www.kaggle.com/deepmatrix/imdb-5000-movie-dataset)
