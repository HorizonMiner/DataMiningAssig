# Question 3 - Association Rule Mining

library(arules)
library(arulesViz)

## 3. Association rules with top food quantity (TuileCookie)
tulieRulesTrans <- as(receiptBinary, "transactions")
tulieRules <- apriori(tulieRulesTrans, parameter= list(minlen=2, target="rules", supp=0.005, conf=0.02), appearance = list(default="rhs",lhs=c("TuileCookie")))
inspect(tulieRules)

# Sorted by lift
quality(tulieRules) <- round(quality(tulieRules), digits=2)
sortedTulieRules <- sort(tulieRules,by="lift")
inspect(sortedTulieRules)

# Remove redundant rules
subset.matrix <- is.subset(sortedTulieRules, sortedTulieRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedTulieRules[!redundant]
inspect(rules.pruned)

# Visualise the rules
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
