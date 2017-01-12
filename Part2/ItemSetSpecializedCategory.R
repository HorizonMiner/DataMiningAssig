

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
  categoryReceipt$OrangeJuie = rep("No", 1000)
  
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