# Question 3 - Association Rule Mining

library(arules)
library(arulesViz)

## 5. Association rules using type of food and drinks with minimum of 2 item sets
indexToType <- function(ItemIndex) {
  goods$ItemType[ItemIndex + 1]
}

receiptWithType <- sapply(receiptSparse, indexToType)
receiptWithType <- as.data.frame(receiptWithType)

typeRulesTrans <- as(receiptWithType, "transactions")

typeRules <- apriori(typeRulesTrans, parameter= list(minlen=2, target="rules",supp=0.02, conf=0.75))
inspect(typeRules)

# Sorted by lift
quality(typeRules) <- round(quality(typeRules), digits=2)
sortedTypeRules <- sort(typeRules,by="lift")
inspect(sortedTypeRules)

# Remove redundant rules
subset.matrix <- is.subset(sortedTypeRules, sortedTypeRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedTypeRules[!redundant]
inspect(rules.pruned)

# Visualise the rules
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)

