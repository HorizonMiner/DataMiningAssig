

getUniqueFoodCategory = function()
{
  unique(itemsTable$FoodCategory)
}

createCategoryTable = function()
{
  categoryReceipt = data.frame(receiptId = seq(1:1000))
  
  categoryReceipt$Eclair = rep(FALSE, 1000)
  categoryReceipt$Tart = rep(FALSE, 1000)
  categoryReceipt$Coffee = rep(FALSE, 1000)
  categoryReceipt$Water = rep(FALSE, 1000)
  categoryReceipt$Cake = rep(FALSE, 1000)
  categoryReceipt$Danish = rep(FALSE, 1000)
  categoryReceipt$Cookie = rep(FALSE, 1000)
  categoryReceipt$Croissant = rep(FALSE, 1000)
  categoryReceipt$Soda = rep(FALSE, 1000)
  categoryReceipt$Lemonade = rep(FALSE, 1000)
  categoryReceipt$Tea = rep(FALSE, 1000)
  categoryReceipt$Meringue = rep(FALSE, 1000)
  categoryReceipt$Pie = rep(FALSE, 1000)
  categoryReceipt$Twist = rep(FALSE, 1000)
  categoryReceipt$BearClaw = rep(FALSE, 1000)
  categoryReceipt$OrangeJuie = rep(FALSE, 1000)
  
  categoryReceipt
}

assignPurchasedItems = function()
{
  for(i in 1:nrow(itemsTable))
  {
    row = itemsTable[i,]
    categoryReceipt[row$ReceiptIndex, match(row$FoodCategory, uniqueCategory) + 1] = TRUE
  }
  categoryReceipt
}


###############################################################################################
uniqueCategory = getUniqueFoodCategory()
categoryReceipt = createCategoryTable()
categoryReceipt = assignPurchasedItems()