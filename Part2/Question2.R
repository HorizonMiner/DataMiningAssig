# Question 2 - Dataset Descriptions

## Read Dataset
# Read 1000-out1.csv
receiptSparse <- read.csv("Dataset/1000-out1.csv", stringsAsFactors = F, header = F) # R will read the columns incorrectly
dim(receiptSparse) # [1] 1048    7

# Read 1000-out2.csv
receiptBinary <- read.csv("Dataset/1000-out2.csv", stringsAsFactors = F, header = F)
dim(receiptBinary) # [1] 1000   51

# Read 1000i.csv
itemsTable <- read.csv("Dataset/1000i.csv", stringsAsFactors = F, header = F)
dim(itemsTable) # [1] 3538    3

# Read goods.csv
goods <- read.csv("Dataset/goods.csv", stringsAsFactors = F)

## Pre-processing
# Read the dataset with correct number of columns.
receiptSparse <- read.csv("Dataset/1000-out1.csv", stringsAsFactors = T, header = F, col.names = c("ReceiptNo.", "Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8"))
dim(receiptSparse) # [1] 1000    9
receiptSparse <- receiptSparse[c(-1)] 

# Add headers to columns in dataset.
colnames(receiptBinary) <- c("ReceiptIndex", "ChocolateCake", "LemonCake", "CasinoCake", "OperaCake", "StrawberryCake", "TruffleCake", "ChocolateEclair", "CoffeeEclair", "VanillaEclair", "NapoleonCake", "AlmondTart", "ApplePie", "AppleTart", "ApricotTart", "BerryTart", "BlackberryTart", "BlueberryTart", "ChocolateTart", "CherryTart", "LemonTart", "PecanTart", "GanacheCookie", "GongolaisCookie", "RaspberryCookie", "LemonCookie", "ChocolateMeringue", "VanillaMeringue", "MarzipanCookie", "TuileCookie", "WalnutCookie", "AlmondCroissant", "AppleCroissant", "ApricotCroissant", "CheeseCroissant", "ChocolateCroissant", "ApricotDanish", "AppleDanish", "AlmondTwist", "AlmondBear Claw", "BlueberryDanish", "LemonLemonade", "RaspberryLemonade", "OrangeJuice", "GreenTea", "BottledWater", "HotCoffee", "ChocolateCoffee", "VanillaFrappuccino", "CherrySoda", "SingleEspresso")
receiptBinary <- receiptBinary[c(-1)]


# Add headers to columns in dataset.
colnames(itemsTable) <- c("ReceiptIndex", "ItemQuantity", "ItemIndex")

## Finding some possible insights
library(ggplot2)

# Food Occurrences
# Get top 10 food occurrences and plot them
food <- colnames(receiptBinary[1:40])
foodOccurrences <- data.frame(Food = food, Occurrences = as.numeric(colSums(receiptBinary[1:40])))
top10food <- foodOccurrences[order(foodOccurrences$Occurrences, decreasing = T),][1:10,]
ggplot(top10food, aes(x = reorder(top10food$Food, -top10food$Occurrences), y = top10food$Occurrences)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top 10 Food Occurrences") +
  labs(x="Food Name",y="Food Occurrences")

# Drink Occurrences
# Get drink occurrences and plot them
drink <- colnames(receiptBinary[41:50])
drinkOccurrences <- data.frame(Drink = drink, Occurrences = as.numeric(colSums(receiptBinary[41:50])))
ggplot(drinkOccurrences, aes(x = reorder(drinkOccurrences$Drink, -drinkOccurrences$Occurrences), y = drinkOccurrences$Occurrences)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top Drink Occurrences") +
  labs(x="Drink Name",y="Drink Occurrences")

# Food Quantity
# Get top 10 food quantity and plot them
indexToName <- function(ItemIndex) {
  itemName = as.character(goods$ItemName[ItemIndex + 1]) # R is not zero-index based
  itemType = as.character(goods$ItemType[ItemIndex + 1])
  paste(itemName, itemType, sep="")
}
itemsTable['ItemName'] <- as.character(0)
# Replace item index to item name
itemsTable$ItemName <- sapply(itemsTable$ItemIndex, indexToName)

foodQuantity <- data.frame(Food = food, Quantity = 0)
for (i in 1:nrow(foodQuantity)) {
  foodQuantity$Quantity[i] <- sum(itemsTable$ItemQuantity[itemsTable$ItemName == foodQuantity$Food[i]])
}
foodQuantity <- foodQuantity[order(foodQuantity$Quantity, decreasing = T),][1:10,]
ggplot(foodQuantity, aes(x = reorder(foodQuantity$Food, -foodQuantity$Quantity), y = foodQuantity$Quantity)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top 10 Food Quantity") +
  labs(x="Food Name",y="Food Quantity")

# Drink Quantity
# Get drink quantity and plot them
drinkQuantity <- data.frame(Drink = drink, Quantity = 0)
for (i in 1:nrow(drinkQuantity)) {
  drinkQuantity$Quantity[i] <- sum(itemsTable$ItemQuantity[itemsTable$ItemName == drinkQuantity$Drink[i]])
}
ggplot(drinkQuantity, aes(x = reorder(drinkQuantity$Drink, -drinkQuantity$Quantity), y = drinkQuantity$Quantity)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top Drink Quantity") +
  labs(x="Drink Name",y="Drink Quantity")

# Item Type
# Get top 10 item type sold and plot them
indexToType <- function(ItemIndex) {
  goods$ItemType[ItemIndex + 1]
}
itemsTable['itemType'] <- as.character(0)
itemsTable$ItemType <- sapply(itemsTable$ItemIndex, indexToType)
byType <- factor(goods$ItemType)
itemType <- data.frame(ItemType = unique(byType), ItemQuantity = 0)
for (i in 1:nrow(itemType)) {
  itemType$ItemQuantity[i] <- sum(itemsTable$ItemQuantity[itemsTable$ItemType == itemType$ItemType[i]])
}

top10Type <- itemType[order(itemType$ItemQuantity, decreasing = T),][1:10,]
ggplot(top10Type, aes(x = reorder(top10Type$ItemType, -top10Type$ItemQuantity), y = top10Type$ItemQuantity)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top 10 Item Type") +
  labs(x="Item Type",y="Quantity Sold")

# Tart
# Get top 10 tart and plot
item <- colnames(receiptBinary)
item <- data.frame(ItemName = item, ItemQuantity = 0, ItemType = as.character(0), stringsAsFactors = F)
for (i in 1:nrow(item)){
  item$ItemQuantity[i] <- sum(itemsTable$ItemQuantity[itemsTable$ItemName == item$ItemName[i]])
  item$ItemType[i] <- itemsTable$ItemType[itemsTable$ItemName == item$ItemName[i]][1]
}

tart <- subset(item, ItemType == 'Tart', select = ItemName:ItemType)
top10Tart <- tart[order(tart$ItemQuantity, decreasing = T),][1:10,]
ggplot(top10Tart, aes(x = reorder(top10Tart$ItemName, -top10Tart$ItemQuantity), y = top10Tart$ItemQuantity)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top 10 Tart Type") +
  labs(x="Tart Type",y="Quantity Sold")

receiptBinary <- as.matrix(receiptBinary)
