source(file="setup.R")
source(file="function.R")

# load dataset
print("loading dataset...")
loadDataSetFromZip()

# Number of rows.
print("number of rows : ")
dim(dataset)

# Names of variables
print("Names of variables in this dataset : ")
names(dataset)

# Number of Empty Cells
print("Number of empty cells in this dataset : ")
numEmptyCellsInDataFrame(dataset)

# Number of Weird HTML Tags
print("Number of Weird HTML Tags : ")
numOfHTMLTag(dataset)

# Number of NA
print("Number of NA in this dataset : ")
numNACellsInDataFrame(dataset)