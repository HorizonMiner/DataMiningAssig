# Question 3 - Association Rule Mining

library(arules)
library(arulesViz)

## 6. Association rules using the top item type sold (tart)
tartRulesTrans <- as(receiptBinary, "transactions")
tartRules <- apriori(tartRulesTrans, parameter= list(minlen=2, target="rules",supp=0.02, conf=0.005), appearance = list(default = 'rhs', lhs = 'BlueberryTart'))
inspect(tartRules)

# Sorted by lift
quality(tartRules) <- round(quality(tartRules), digits=2)
sortedTartRules <- sort(tartRules,by="lift")
inspect(sortedTartRules)

# Remove redundant rules
subset.matrix <- is.subset(sortedTartRules, sortedTartRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedTartRules[!redundant]
inspect(rules.pruned)

# Visualise the rules
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
