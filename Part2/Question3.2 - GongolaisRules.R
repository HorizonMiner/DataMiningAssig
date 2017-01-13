# Question 3 - Association Rule Mining

library(arules)
library(arulesViz)

## 2. Association rules with top food occurence (GongolaisCookie)
gongolaisRulesTrans <- as(receiptBinary, "transactions")

gongolaisRules <- apriori(gongolaisRulesTrans, parameter= list(minlen=2, target="rules", supp=0.005, conf=0.02), appearance = list(default="rhs",lhs=c("GongolaisCookie")))
inspect(gongolaisRules)

# Sorted by lift
quality(gongolaisRules) <- round(quality(gongolaisRules), digits=2)
sortedGongolaisRules <- sort(gongolaisRules,by="lift")
inspect(sortedGongolaisRules)

# Remove redundant rules
subset.matrix <- is.subset(sortedGongolaisRules, sortedGongolaisRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedGongolaisRules[!redundant]
inspect(rules.pruned)

# Visualise the rules
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
