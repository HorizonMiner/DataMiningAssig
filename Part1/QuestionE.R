# QUestion E - Data Pre-processing

# Load dataset
dataset <- read.csv("dataset/movie_metadata.csv")

## Issue 1: There are empty values in observations.
# Solution: Replace empty columns with NAs.
print("Replace empty columns with NAs:")
dataset[dataset == ''] <- NA

## Issue 2: All movie titles are delimited with a non-ascii character.
# Solution: Replace the non-ascii character with empty character.
print("Replace the non-ascii character with empty character:")
cleanTitle <- function(movie_name){
  movie_name <- sub('Â', '', movie_name)
}
dataset$movie_title <- sapply(dataset$movie_title, FUN = cleanTitle)

## Issue 3: There are duplicates in the dataset.
# Solution: Remove duplicated rows.
print("Remove duplicated rows:")
dataset <- unique.data.frame(dataset)

## Issue 4: There are duplicate movie titles.
# Solution: Remove duplicated movie titles with different directors.
print("Remove duplicated movie titles with different directors:")
exclude <- duplicated(dataset[ ,c("movie_title", "director_name")], fromLast = F)
dataset <- dataset[!exclude, ]

## Issue 5: There are NAs in the dataset.
# Solution: 
# We cannot simply remove the rows with NAs because other columns still contain
# important information.
# For duration column, we can apply imputation. 
# Since duration is MCAR, we use median for the imputation.
library(Hmisc)
library(ggplot2)

# Plot of duration (in minute) agaisnt gross (in million)
print("Plot of duration (in minute) agaisnt gross (in million):")
ggplot(dataset, aes(x = dataset$gross/1000000, y = dataset$duration)) + 
  geom_point(alpha = 1/10) +
  labs(title = "Gross and Duration for Movies", y = "Duration (minute)", x = "Gross (million)") +
  theme_bw() 
# This plot shows that gross has no effect on duration.

# Plot of duration (in minute) agaisnt budget (in million)
print("Plot of duration (in minute) agaisnt budget (in million):")
ggplot(dataset, aes(x = dataset$duration, y = dataset$budget/1000000)) + 
  geom_point(alpha = 1/10) +
  labs(title = "Budget and Duration for Movies", y = "Duration (minute)", x = "Budget (million)") +
  theme_bw() 
# This plot shows that budget has no effect on duration.

# Since gross and budget have no effect on duration,
# we can apply median imputation to duration column.
print("Apply median imputation to duration column.")
dataset$duration <- impute(dataset$duration, median)

# Number of imputed observations
print("Number of imputed observations:")
sum(is.imputed(dataset$duration))

## Issue 6: There are composite words in keyword and genre.
# Solution: Melt genre
library(reshape)

movies <- read.csv("dataset/movie_metadata.csv", stringsAsFactors = FALSE)

# Split genre into a vector of genres
print("Split genre into a vector of genres.")
movies$genres <- strsplit(movies$genres, "|", fixed = TRUE)

# Melt genre
print("Melt genre.")
directorWithGenres <- melt(movies$genres)
colnames(directorWithGenres) <- c("genres", "director")

# Assign director name to molten genre
print("Assign director name to molten genre.")
i <- 1
for (x in directorWithGenres$director){
  directorWithGenres$director[i] <- movies$director_name[x]
  i <- i + 1
}

## Issue 7: Column order in dataset is random.
# Solution: Rearrange column order in dataset.
print("Rearrange column order in dataset.")
dataset <- dataset[, c(12,28,2,5,22,10,17,24,3,13,19,26,20,21,23,9,27,1,4,11,8,7,25,15,6,14,16,18)]

print("Save the arranged dataset to a csv file.")
write.csv(dataset, file="rearrangedDf.csv")