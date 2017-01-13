# Question 3 - Association Rule Mining

library(arules)
library(arulesViz)

## There are three combinations in a single receipt:
## a. Receipt with only food
## b. Receipt with only drink
## c. Receipt with food and drink

## 1. Association rules that include all three combinations with minimum of 2 item sets 
allRulesTrans <- as(receiptBinary, "transactions")

allRules <- apriori(allRulesTrans, parameter= list(minlen=2, target="rules", supp=0.02, conf=0.75))
inspect(allRules)

# Sorted by lift
quality(allRules) <- round(quality(allRules), digits=2)
sortedAllRules <- sort(allRules,by="lift")
inspect(sortedAllRules)

# Remove redundant rules
subset.matrix <- is.subset(sortedAllRules, sortedAllRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedAllRules[!redundant]
inspect(rules.pruned)

# Visualise the rules
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
