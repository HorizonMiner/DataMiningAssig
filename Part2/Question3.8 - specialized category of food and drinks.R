ItemNames = c()

#################################################################################################################
initFoodName = function()
{
  ItemNames = colnames(receiptBinary)[1:50]
  ItemNames
}

ItemNames = initFoodName()

getFoodNamesBasedOnIndex = function(index)
{
  ItemNames[index+1]
}

foodNameInArray = function(vector)
{
  foodVec = c()
  for(i in vector)
  {
    foodVec = append(foodVec, getFoodNamesBasedOnIndex(i))
  }
  foodVec
}

addFoodNameColumnIntoItemsTable = function()
{
  itemsTable$FoodName = foodNameInArray(itemsTable$ItemIndex)
  itemsTable
}

####################################################################################################################

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

addFoodCategoryAsColumn = function()
{
  itemsTable$FoodCategory = categorize(itemsTable$FoodName)
  itemsTable
}

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

################################################################################################################

itemsTable = addFoodNameColumnIntoItemsTable()
itemsTable = addFoodCategoryAsColumn()


################################################################################################################


getUniqueFoodCategory = function()
{
  unique(itemsTable$FoodCategory)
}

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

assignPurchasedItems = function()
{
  for(i in 1:nrow(itemsTable))
  {
    row = itemsTable[i,]
    categoryReceipt[row$ReceiptIndex, match(row$FoodCategory, uniqueCategory) + 1] = "Yes"
  }
  categoryReceipt
}


###############################################################################################
uniqueCategory = getUniqueFoodCategory()
categoryReceipt = createCategoryTable()
categoryReceipt = assignPurchasedItems()
categoryReceipt = categoryReceipt[, 2:17]

for(i in 1:ncol(categoryReceipt))
{
  categoryReceipt[, i] = as.factor(categoryReceipt[, i])
  
  
}

###############################################################################################

library(arules)
rules.cat1 = apriori(categoryReceipt, control=list(verbose=F), parameter=list(minlen=2, supp=0.01, conf=0.01), appearance=list(lhs=c("Cake=Yes", "Tart=Yes", "Cookie=Yes", "Croissant=Yes", "Danish=Yes", "Coffee=Yes"), rhs=c("Eclair=Yes", "Water=Yes", "Soda=Yes", "Lemonade=Yes", "Meringue=Yes", "Pie=Yes", "Twist=Yes", "BearClaw=Yes", "OrangeJuice=Yes"), default="none"))

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
