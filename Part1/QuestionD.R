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