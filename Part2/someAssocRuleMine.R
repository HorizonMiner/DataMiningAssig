rules.cat1 = apriori(categoryReceipt, control=list(verbose=F), parameter=list(minlen=2, supp=0.01, conf=0.01), appearance=list(lhs=c("Cake=Yes", "Tart=Yes", "Cookie=Yes", "Croissant=Yes", "Danish=Yes", "Coffee=Yes"), rhs=c("Eclair=Yes", "Water=Yes", "Soda=Yes", "Lemonade=Yes", "Meringue=Yes", "Pie=Yes", "Twist=Yes", "BearClaw=Yes", "OrangeJuie=Yes"), default="none"))

rules.sort = sort(rules.cat1, by="confidence")

inspect(rules.sort)

subset.matrix <- is.subset(rules.sort, rules.sort)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- rules.sort[!redundant]
inspect(rules.pruned)

library(arulesViz)
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
