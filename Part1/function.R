# function to calculate number of empty cells with no values
numEmptyCellsInDataFrame = function(dataFrame)
{
  boolVec = as.vector(apply(dataFrame, 2, isCellEmpty))
  unname(summary(boolVec)["TRUE"])
}

# function to get whether the cell is empty
isCellEmpty = function(cell)
{
  as.character(cell) == ""
}

# Check the number of NA in one data frame
numNACellsInDataFrame = function(dataFrame)
{
  sum(is.na(dataFrame))
}

# Find the number of cells with html or xml tags
numOfHTMLTag = function(dataFrame)
{
  boolVec = as.vector(apply(dataFrame, 2, cellHasHTMLTag))
  unname(summary(boolVec)["TRUE"])
}

# Check whether the cell has html or xml tags
cellHasHTMLTag = function(cell)
{
  grepl("<.+>|/.+", as.character(cell))
}