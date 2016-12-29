# Question D - Data Quality Issues

# Load dataset
dataset <- read.csv("dataset/movie_metadata.csv")

## Issue 1
## There are NAs in the dataset.

# Number of NAs
print("Number of NAs:")
sum(is.na(dataset)) # yields 2059

## Issue 2
## There are empty values in observations.

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

# Number of empty cells
print("Number of empty cells in this dataset:")
numEmptyCellsInDataFrame(dataset) # yields 639

## Issue 3
## All movie titles are delimited with a non-ascii character.

# Movie title for the first ten rows in this dataset
print("Movie title for the first ten rows in this dataset:")
dataset$movie_title[1:10]

## Issue 4
## There are composite words in keyword and genre.

# Genres and plot keywords for the first four rows in this dataset
print("Genres and plot keywords for the first four rows in this dataset:")
dataset[1:4, c("genres", "plot_keywords")]

## Issue 5
## There are duplicates in the dataset.

# Number of duplicates
print("Number of duplicates:")
sum(duplicated(dataset)) # yields 45

## Issue 6
## There are duplicate movie titles. However, it cannot be removed completely
## since there may be different directors with the same movie title or 
## different number of user votes.

# Number of duplicate movie titles
print("Number of duplicate movie titles:")
sum(duplicated(dataset$movie_title)) # yields 126

# Number of duplicate movie titles with director
print("Number of duplicate movie titles with director:")
sum(duplicated(dataset[,c("movie_title", "director_name")])) # yields 124
# This shows us that there are 2 movies with the same title but with different
# directors.

# Number of duplicate movie titles with number of voted users
print("Number of duplicate movie titles with number of voted users:")
sum(duplicated(dataset[,c("movie_title", "num_voted_users")])) # yields 47
# This shows us there are 79 movies with the same title but with different
# votes.

## Issue 7
## Column order in dataset is random.
print("Sixth variable to eighth variable:")
names(dataset)[6:8]
# This shows that column order is random.