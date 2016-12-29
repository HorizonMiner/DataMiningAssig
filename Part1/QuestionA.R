# Question A - Description of Dataset

# Load dataset
dataset <- read.csv("dataset/movie_metadata.csv")

# 1. Number of observations and variables
print("Number of observations and variables:")
dim(dataset) # yields 5043 28

# 2. Names of variables
print("Names of variables:")
names(dataset)