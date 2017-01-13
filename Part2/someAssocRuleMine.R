rules.cat1 = apriori(categoryReceipt, control=list(verbose=F), parameter=list(minlen=2, supp=0.01, conf=0.01), appearance=list(lhs=c("Cake=Yes", "Tart=Yes", "Cookie=Yes", "Croissant=Yes", "Danish=Yes", "Coffee=Yes"), rhs=c("Eclair=Yes", "Water=Yes", "Soda=Yes", "Lemonade=Yes", "Meringue=Yes", "Pie=Yes", "Twist=Yes", "BearClaw=Yes", "OrangeJuie=Yes"), default="none"))

rules.sort = sort(rules.cat1, by="confidence")

inspect(rules.sort)