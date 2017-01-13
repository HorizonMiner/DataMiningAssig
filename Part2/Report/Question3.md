# 3. Rule Mining Process
We use Apriori algorithm (inside `arules` package) for all the rules.

Load library required for ARM:
```r
library(arules)
library(arulesViz)
```

## 1. Association rules that include all three combinations with minimum of 2 item sets
There are three combinations in a single receipt:

1. Receipt with only food

2. Receipt with only drink

3. Receipt with food and drink

```r
allRulesTrans <- as(receiptBinary, "transactions")

allRules <- apriori(allRulesTrans, parameter= list(minlen=2, target="rules", supp=0.02, conf=0.75))
inspect(allRules)
```

Parameter setting and time required:

![All Rules Param & Time](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.1/allRulesParam%26Time.png)

Sorted by lift:
```r
quality(allRules) <- round(quality(allRules), digits=2)
sortedAllRules <- sort(allRules,by="lift")
inspect(sortedAllRules)
```

Remove redundant rules:
```r
subset.matrix <- is.subset(sortedAllRules, sortedAllRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedAllRules[!redundant]
inspect(rules.pruned)
```

Visualise the rules:
```r
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
```

## 2. Association rules with top food occurence (GongolaisCookie)
```r
gongolaisRulesTrans <- as(receiptBinary, "transactions")

gongolaisRules <- apriori(gongolaisRulesTrans, parameter= list(minlen=2, target="rules", supp=0.005, conf=0.02), appearance = list(default="rhs",lhs=c("GongolaisCookie")))
inspect(gongolaisRules)
```

Parameter setting and time required:

![Gongolais Rules Time & Param](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.2/gongolaisRulesParam%26Time.png)

Sorted by lift:
```r
quality(gongolaisRules) <- round(quality(gongolaisRules), digits=2)
sortedGongolaisRules <- sort(gongolaisRules,by="lift")
inspect(sortedGongolaisRules)
```

Remove redundant rules:
```r
subset.matrix <- is.subset(sortedGongolaisRules, sortedGongolaisRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedGongolaisRules[!redundant]
inspect(rules.pruned)
```

Visualise the Rules:
```r
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
```

## 3. Association rules with top food quantity (TuileCookie)
```r
tulieRulesTrans <- as(receiptBinary, "transactions")
tulieRules <- apriori(tulieRulesTrans, parameter= list(minlen=2, target="rules", supp=0.005, conf=0.02), appearance = list(default="rhs",lhs=c("TuileCookie")))
inspect(tulieRules)
```

Parameter setting and time required:

![Tulie Rules Time & Param](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.3/tulieRulesParam%26Time.png)

Sorted by lift:
```r
quality(tulieRules) <- round(quality(tulieRules), digits=2)
sortedTulieRules <- sort(tulieRules,by="lift")
inspect(sortedTulieRules)
```

Remove redundant rules:
```r
subset.matrix <- is.subset(sortedTulieRules, sortedTulieRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedTulieRules[!redundant]
inspect(rules.pruned)
```

Visualise the Rules:
```r
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
```

## 4. Association rules with top drink occurrence/quantity (HotCoffee)
```r
hotCoffeeRulesTrans <- as(receiptBinary, "transactions")
hotCoffeeRules <- apriori(hotCoffeeRulesTrans, parameter= list(minlen=2, target="rules", supp=0.001, conf=0.02), appearance = list(default="rhs",lhs=c("HotCoffee")))
inspect(hotCoffeeRules)
```

Parameter setting and time required:

![Hot Coffee Rules Param & Time](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.4/hotCoffeeRulesParam%26Time.png)

Sorted by lift:
```r
quality(hotCoffeeRules) <- round(quality(hotCoffeeRules), digits=2)
sortedHotCoffeeRules <- sort(hotCoffeeRules,by="lift")
inspect(sortedHotCoffeeRules)
```

Remove redundant rules:
```r
subset.matrix <- is.subset(sortedHotCoffeeRules, sortedHotCoffeeRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedHotCoffeeRules[!redundant]
inspect(rules.pruned)
```

Visualise the rules:
```r
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
```

## 5. Association rules using type of food and drinks with minimum of 2 item sets
```r
indexToType <- function(ItemIndex) {
  goods$ItemType[ItemIndex + 1]
}

receiptWithType <- sapply(receiptSparse, indexToType)
receiptWithType <- as.data.frame(receiptWithType)

typeRulesTrans <- as(receiptWithType, "transactions")

typeRules <- apriori(typeRulesTrans, parameter= list(minlen=2, target="rules",supp=0.02, conf=0.75))
inspect(typeRules)
```

Parameter setting and time required:

![Type Rules Param & Time](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.5/typeRulesParam%26Time.png)

Sorted by lift:
```r
quality(typeRules) <- round(quality(typeRules), digits=2)
sortedTypeRules <- sort(typeRules,by="lift")
inspect(sortedTypeRules)
```

Remove redundant rules:
```r
subset.matrix <- is.subset(sortedTypeRules, sortedTypeRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedTypeRules[!redundant]
inspect(rules.pruned)
```

Visualise the Rules:
```r
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
```

## 6. Association rules using the top item type sold (tart)
```r
tartRulesTrans <- as(receiptBinary, "transactions")
tartRules <- apriori(tartRulesTrans, parameter= list(minlen=2, target="rules",supp=0.02, conf=0.005), appearance = list(default = 'rhs', lhs = 'BlueberryTart'))
inspect(tartRules)
```

Parameter setting and time required:

![Tart Rules Param & Time](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.6/tartRulesParam%26Time.png)

Sorted by lift:
```r
quality(tartRules) <- round(quality(tartRules), digits=2)
sortedTartRules <- sort(tartRules,by="lift")
inspect(sortedTartRules)
```

Remove redundant rules:
```r
subset.matrix <- is.subset(sortedTartRules, sortedTartRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedTartRules[!redundant]
inspect(rules.pruned)
```

Visualise the Rules:
```r
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
```

## 7. Association rules include only both food and drink
Create an empty logical isFoodAndDrink column:
```r
indexToName <- function(ItemIndex) {
  itemName = as.character(goods$ItemName[ItemIndex + 1]) # R is not zero-index based
  itemType = as.character(goods$ItemType[ItemIndex + 1])
  paste(itemName, itemType, sep="")
}
```

Replace item index to item name:
```r
receiptWithName <- sapply(receiptSparse, indexToName)
receiptWithName[receiptWithName == 'NANA'] <- NA
receiptWithName <- as.data.frame(receiptWithName)
receiptWithName['isFoodAndDrink'] <- as.character(0)
```

Function to determine category whether it is food or drink:
```r
whatType <- function(itemname) {
  as.character(goods$ItemCategory[itemname])
}
```

Determine whether a row contains both food and drink:
```r
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
```

Get only rows that contains both food and drink:
```r
foodAndDrink <- subset(receiptWithName, isFoodAndDrink==TRUE, select=Item1:Item8)
foodAndDrink_trans <- as(foodAndDrink, "transactions")
```

Use Apriori to generate rules for food and drink:
```r
FDrules <- apriori(foodAndDrink_trans, parameter= list(minlen=1, target="rules",supp=0.02, conf=0.75))
inspect(FDrules)
```

Parameter setting and time required:

![FD Rules Param & Time](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.7/FDrulesParam%26Time.png)

Sorted by lift:
```r
quality(FDrules) <- round(quality(FDrules), digits=2)
sortedFDRules <- sort(FDrules,by="lift")
inspect(rules.sorted)
```

Remove redundant rules:
```r
subset.matrix <- is.subset(sortedFDRules, sortedFDRules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- sortedFDRules[!redundant]
inspect(rules.pruned)
```

Visualise the rules:
```r
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
```

## 8. Association rules with specialized category of food and drinks 

Obtain food and drink names
```r
initFoodName = function()
{
  ItemNames = colnames(receiptBinary)[1:50]
  ItemNames
}
```

Obtain food or drink names based on ItemIndex
```r
getFoodNamesBasedOnIndex = function(index)
{
  ItemNames[index+1]
}
```

Obtain food or drink names based on a vector of ItemIndex and return a vector
```r
foodNameInArray = function(vector)
{
  foodVec = c()
  for(i in vector)
  {
    foodVec = append(foodVec, getFoodNamesBasedOnIndex(i))
  }
  foodVec
}
```

Add food or drink name vector as a new column into itemsTable data frame
```r
addFoodNameColumnIntoItemsTable = function()
{
  itemsTable$FoodName = foodNameInArray(itemsTable$ItemIndex)
  itemsTable
}
```

Categorize items in a vector based on their food or drink name and return a vector
```r
categorize = function(vector)
{
  category = c()
  for(c in vector)
  {
    if(isFood(c))
    {
      category = append(category, getFoodCategory(c))
    }
    else
    {
      category = append(category, getDrinkCategory(c))
    }
  }
  category
}
```

A wrappper function to add a new column of food category into itemsTable
```r
addFoodCategoryAsColumn = function()
{
  itemsTable$FoodCategory = categorize(addFoodCategoryAsColumn())
  itemsTable
}
```

Companion function for categorize(). Used to check whether the food or drink name is a drink.
```r
# use this in categorize
isDrink = function(char)
{
  constDrinkCategory = c('Lemonade', 'Juice', 'Tea', 'Water', 'Coffee', 'Frappucino', 'Soda', 'Espresso')
  bool = FALSE;
  
  for(i in constDrinkCategory)
  {
    if(length(grep(i, char)) != 0)
    {
      bool = TRUE
      break
    }
  }
  
  bool 
}
```

Companion function for categorize(). Used to check whether the food or drink name is a drink.
```r
# use this in categorize
isFood = function(char)
{
  constFoodCategory = c('Cake', 'Eclair', 'Tart', 'Pie', 'Cookie', 'Meringue', 'Croissant', 'Twist', 'Danish', 'BearClaw')
  bool = FALSE;
  
  for(i in constFoodCategory)
  {
    if(length(grep(i, char)) != 0)
    {
      bool = TRUE
      break
    }
  }
  
  bool 
}
```

Companion function of categorize(). Use the food name to get food category.
```r
# use this in categorize
getFoodCategory = function(char)
{
  constFoodCategory = c('Cake', 'Eclair', 'Tart', 'Pie', 'Cookie', 'Meringue', 'Croissant', 'Danish', 'BearClaw', 'Twist')
  food = '';
  
  for(i in constFoodCategory)
  {
    if(length(grep(i, char)) != 0)
    {
      food = i
      break
    }
  }
  
  food
}
```

Companion function for categorize(). Use drink name to determine drink category.
```r
# use this in categorize
getDrinkCategory = function(char)
{
  constDrinkCategory = c('Lemonade', 'OrangeJuice', 'Tea', 'Water', 'Coffee', 'Frappuccino', 'Soda', 'Espresso')
  drink = '';
  
  for(i in constDrinkCategory)
  {
    if(length(grep(i, char)) != 0)
    {
      drink = i
      break
    }
  }
  
  if(drink == 'Frappuccino' || drink == 'Espresso')
    drink = 'Coffee'
  
  drink
}
```

Run the functions to add 2 new columns onto itemsTable : FoodName and FoodCategory.
```r
itemsTable = addFoodNameColumnIntoItemsTable()
itemsTable = addFoodCategoryAsColumn()
```

Function to get vector of unique food categoryin the itemTable
```r
getUniqueFoodCategory = function()
{
  unique(itemsTable$FoodCategory)
}
```

Create an empty data frame to hold receipt from 1 to 1000 against the categories of items whether that particular receipt has or not.
```r
createCategoryTable = function()
{
  categoryReceipt = data.frame(receiptId = seq(1:1000), stringsAsFactors = TRUE)
  
  categoryReceipt$Eclair = rep("No", 1000)
  categoryReceipt$Tart = rep("No", 1000)
  categoryReceipt$Coffee = rep("No", 1000)
  categoryReceipt$Water = rep("No", 1000)
  categoryReceipt$Cake = rep("No", 1000)
  categoryReceipt$Danish = rep("No", 1000)
  categoryReceipt$Cookie = rep("No", 1000)
  categoryReceipt$Croissant = rep("No", 1000)
  categoryReceipt$Soda = rep("No", 1000)
  categoryReceipt$Lemonade = rep("No", 1000)
  categoryReceipt$Tea = rep("No", 1000)
  categoryReceipt$Meringue = rep("No", 1000)
  categoryReceipt$Pie = rep("No", 1000)
  categoryReceipt$Twist = rep("No", 1000)
  categoryReceipt$BearClaw = rep("No", 1000)
  categoryReceipt$OrangeJuice = rep("No", 1000)
  
  categoryReceipt
}
```

This function match item receipt index and food cetegory frpm itemsTable to mark "Yes" on the new dataframe that that receipt of that index has purchased such category of items.
```r
assignPurchasedItems = function()
{
  for(i in 1:nrow(itemsTable))
  {
    row = itemsTable[i,]
    categoryReceipt[row$ReceiptIndex, match(row$FoodCategory, uniqueCategory) + 1] = "Yes"
  }
  categoryReceipt
}
```

Runs the functions.
```r
uniqueCategory = getUniqueFoodCategory()
categoryReceipt = createCategoryTable()
categoryReceipt = assignPurchasedItems()
```

Get the data frame without receipt index.
```r
categoryReceipt = categoryReceipt[, 2:17]
```

Convert all columns as factor.
```r
for(i in 1:ncol(categoryReceipt))
{
  categoryReceipt[, i] = as.factor(categoryReceipt[, i])
}
```

Mine the data frame with assoc rule mining.
```r
rules.cat1 = apriori(categoryReceipt, control=list(verbose=F), parameter=list(minlen=2, supp=0.01, conf=0.01), appearance=list(lhs=c("Cake=Yes", "Tart=Yes", "Cookie=Yes", "Croissant=Yes", "Danish=Yes", "Coffee=Yes"), rhs=c("Eclair=Yes", "Water=Yes", "Soda=Yes", "Lemonade=Yes", "Meringue=Yes", "Pie=Yes", "Twist=Yes", "BearClaw=Yes", "OrangeJuice=Yes"), default="none"))

rules.sort = sort(rules.cat1, by="confidence")

inspect(rules.sort)
```

Parameter and Time required.
```
Parameter specification:
 confidence minval smax arem  aval originalSupport maxtime support minlen maxlen target   ext
       0.01    0.1    1 none FALSE            TRUE       5    0.01      2     10  rules FALSE

Algorithmic control:
 filter tree heap memopt load sort verbose
    0.1 TRUE TRUE  FALSE TRUE    2    TRUE

Absolute minimum support count: 10 

set item appearances ...[15 item(s)] done [0.00s].
set transactions ...[15 item(s), 1000 transaction(s)] done [0.00s].
sorting and recoding items ... [15 item(s)] done [0.00s].
creating transaction tree ... done [0.00s].
checking subsets of size 1 2 3 4 5 done [0.00s].
writing ... [103 rule(s)] done [0.00s].
creating S4 object  ... done [0.00s].
```

Prune rules
```r
subset.matrix <- is.subset(rules.sort, rules.sort)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned <- rules.sort[!redundant]
inspect(rules.pruned)
```

Plot visualizations
```r
library(arulesViz)
plot(rules.pruned)
plot(rules.pruned, method="graph",interactive = TRUE)
plot(rules.pruned, method="grouped", interactive= TRUE)
```

Justification of using such support and confidence.
* Support : Occurance of each item in 1000 receipts are very less and many receipts has not much items.
* Confidence : Items are not frequently purchased with each other.