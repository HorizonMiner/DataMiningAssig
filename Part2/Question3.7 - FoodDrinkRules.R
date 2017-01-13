# Question 3 - Association Rule Mining

library(arules)
library(arulesViz)

## 7. Association rules include only both food and drink
# Create an empty logical isFoodAndDrink column
indexToName <- function(ItemIndex) {
  itemName = as.character(goods$ItemName[ItemIndex + 1]) # R is not zero-index based
  itemType = as.character(goods$ItemType[ItemIndex + 1])
  paste(itemName, itemType, sep="")
}

# Replace item index to item name
receiptWithName <- sapply(receiptSparse, indexToName)
receiptWithName[receiptWithName == 'NANA'] <- NA
receiptWithName <- as.data.frame(receiptWithName)
receiptWithName['isFoodAndDrink'] <- as.character(0)

# Function to determine category whether it is food or drink
whatType <- function(itemname) {
  as.character(goods$ItemCategory[itemname])
}

# Determine whether a row contains both food and drink
for (r in 1:nrow(receiptWithName)) {
  food = FALSE
  drink = FALSE
  for (col in 1:(ncol(receiptWithName)-1)) {
    if (!is.na(receiptWithName[r, col])) {
      if (whatType(receiptWithName[r, col]) == "Food")
        food = TRUE
      else if (whatType(receiptWithName[r, col]) == "Drink")
        drink = TRUE  
    }
  }
  receiptWithName[r, ncol(receiptWithName)] <- food & drink
}

# Get only rows that contains both food and drink
foodAndDrink <- subset(receiptWithName, isFoodAndDrink==TRUE, select=Item1:Item8)
foodAndDrink_trans <- as(foodAndDrink, "transactions")

# Use Apriori to generate rules for food and drink
FDrules <- apriori(foodAndDrink_trans, parameter= list(minlen=1, target="rules",supp=0.02, conf=0.75))
inspect(FDrules)

# Sorted by lift
quality(FDrules) <- round(quality(FDrules), digits=2)
sortedFDRules <- sort(FDrules,by="lift")
inspect(sortedFDRules)

# Remove redundant rules
subset.matrix <- is.subset(sortedFDRules, sortedFDRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedFDRules[!redundant]
inspect(rules.pruned)

# Visualise the rules
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
