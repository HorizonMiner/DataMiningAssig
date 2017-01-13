# Question 3 - Association Rule Mining

library(arules)
library(arulesViz)

## 4. Association rules with top drink occurrence/quantity (HotCoffee)
hotCoffeeRulesTrans <- as(receiptBinary, "transactions")
hotCoffeeRules <- apriori(hotCoffeeRulesTrans, parameter= list(minlen=2, target="rules", supp=0.001, conf=0.02), appearance = list(default="rhs",lhs=c("HotCoffee")))
inspect(hotCoffee)

# Sorted by lift
quality(hotCoffeeRules) <- round(quality(hotCoffeeRules), digits=2)
sortedHotCoffeeRules <- sort(hotCoffeeRules,by="lift")
inspect(sortedHotCoffeeRules)

# Remove redundant rules
subset.matrix <- is.subset(sortedHotCoffeeRules, sortedHotCoffeeRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedHotCoffeeRules[!redundant]
inspect(rules.pruned)

# Visualise the rules
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
