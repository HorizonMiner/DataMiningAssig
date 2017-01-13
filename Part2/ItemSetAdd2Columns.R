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
  constDrinkCategory = c('Lemonade', 'OrangeJuie', 'Tea', 'Water', 'Coffee', 'Frappuccino', 'Soda', 'Espresso')
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
