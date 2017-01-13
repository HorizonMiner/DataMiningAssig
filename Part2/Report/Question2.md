# 2. Dataset Description
The bakery database consists of 5 tables. The table of interest is Receipt since association mining rule is mainly focused on what are the items purchased by customer. This dataset was obtain from a bakery which located at West Coast of the United States. The bakery chain has a menu of about 40 pastries and 10 coffee drinks. There are four canonical sets and the first one which contains 1000 receipts was chosen for association rule mining task. 

## Datasets
There is no header in the datasets.
The chosen canonical set have three CSV files available for the task:

### 1. 1000-out1.csv
This dataset is represented in sparse vector form.
```r
receiptSparse <- read.csv("Dataset/1000-out1.csv", stringsAsFactors = F, header = F)
```

Dimensions:
```r
dim(receiptSparse) 
```

Output:
```
## [1] 1048    7
```

The first column of the set is receipts' index, followed by the items' index in the receipt. The number of columns is incorrectly identified as 7 instead of 9 because the columns is inconsistent. (Supposed to have only 1000 receipts)

### 2. 1000-out2.csv 
This dataset is represented in binary vetor form.
```r
receiptBinary <- read.csv("Dataset/1000-out2.csv", stringsAsFactors = F, header = F)
```

Dimensions: 
```r 
dim(receiptBinary) 
``` 

Output:
```
## [1] 1000   51
```

The first column of the set is receipts' index, followed by 50 unique items available for selling in the bakery. The 0's and 1's indicating if an item was on a given receipt. There is no header in this dataset. 

### 3. 1000i.csv
This dataset is the CSV version of Item Tables in the database.
```r
itemsTable <- read.csv("Dataset/1000i.csv", stringsAsFactors = F, header = F)
```

Dimensions:
```r
dim(itemsTable)
```

Output:
```
## [1] 3538    3
```

The first column of this set is receipts' index followed by items' index and their quantity.

### 4. goods.csv
The table contains item index, item name, item type, item price and item category.
```r
goods <- read.csv("Dataset/goods.csv", stringsAsFactors = F)
```

## Pre-proccessing
### 1. 1000-out1.csv
Read the dataset with correct number of columns.
```r
receiptSparse <- read.csv("Dataset/1000-out1.csv", stringsAsFactors = T, header = F, col.names = c("ReceiptNo.", "Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8"))
```

Dimensions:
```r
dim(receiptSparse)
```

Output:
```
## [1] 1000    9
```

Drop receipt column:
```r
receiptSparse <- receiptSparse[c(-1)]
```

### 2. 1000-out2.csv
Add headers to columns in dataset.
```r
colnames(receiptBinary) <- c("ReceiptIndex", "ChocolateCake", "LemonCake", "CasinoCake", "OperaCake", "StrawberryCake", "TruffleCake", "ChocolateEclair", "CoffeeEclair", "VanillaEclair", "NapoleonCake", "AlmondTart", "ApplePie", "AppleTart", "ApricotTart", "BerryTart", "BlackberryTart", "BlueberryTart", "ChocolateTart", "CherryTart", "LemonTart", "PecanTart", "GanacheCookie", "GongolaisCookie", "RaspberryCookie", "LemonCookie", "ChocolateMeringue", "VanillaMeringue", "MarzipanCookie", "TuileCookie", "WalnutCookie", "AlmondCroissant", "AppleCroissant", "ApricotCroissant", "CheeseCroissant", "ChocolateCroissant", "ApricotDanish", "AppleDanish", "AlmondTwist", "AlmondBear Claw", "BlueberryDanish", "LemonLemonade", "RaspberryLemonade", "OrangeJuice", "GreenTea", "BottledWater", "HotCoffee", "ChocolateCoffee", "VanillaFrappuccino", "CherrySoda", "SingleEspresso")
```

Drop receipt column:
```r
receiptBinary <- receiptBinary[c(-1)]
```

### 3. 1000i.csv
Add headers to coumns in dataset.
```r
colnames(itemsTable) <- c("ReceiptIndex", "ItemQuantity", "ItemIndex")
```

## Finding Possible Insights
Load library required for plotting:
```r
library(ggplot2)
```

### 1. Top 10 Food Occurrences
Get top 10 food occurrences and plot them:
```r
food <- colnames(receiptBinary[1:40])

foodOccurrences <- data.frame(Food = food, Occurrences = as.numeric(colSums(receiptBinary[1:40])))

top10food <- foodOccurrences[order(foodOccurrences$Occurrences, decreasing = T),][1:10,]

ggplot(top10food, aes(x = reorder(top10food$Food, -top10food$Occurrences), y = top10food$Occurrences)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top 10 Food Occurrences") +
  labs(x="Food Name",y="Food Occurrences")
```

![Top 10 Food Occurrences](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/2/Top10FoodOccurrence.png)

### 2. Top Drink Occurrences
Get drink occurrences and plot them:
```r
drink <- colnames(receiptBinary[41:50])

drinkOccurrences <- data.frame(Drink = drink, Occurrences = as.numeric(colSums(receiptBinary[41:50])))

ggplot(drinkOccurrences, aes(x = reorder(drinkOccurrences$Drink, -drinkOccurrences$Occurrences), y = drinkOccurrences$Occurrences)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top Drink Occurrences") +
  labs(x="Drink Name",y="Drink Occurrences")
```

![Drink Occurrences](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/2/DrinkOccurrence.png)

### 3. Top 10 Food Quantity
Replace item index with item name:
```r
indexToName <- function(ItemIndex) {
  itemName = as.character(goods$ItemName[ItemIndex + 1]) # R is not zero-index based
  itemType = as.character(goods$ItemType[ItemIndex + 1])
  paste(itemName, itemType, sep="")
}
itemsTable['ItemName'] <- as.character(0)
itemsTable$ItemName <- sapply(itemsTable$ItemIndex, indexToName)
```

Get top 10 food quantity and plot them:
```r
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
```

![Top 10 Food Quantity](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/2/Top10FoodQuantitySold.png)

### 4. Top Drink Quantity
Get drink quantity and plot them:
```r
drinkQuantity <- data.frame(Drink = drink, Quantity = 0)
for (i in 1:nrow(drinkQuantity)) {
  drinkQuantity$Quantity[i] <- sum(itemsTable$ItemQuantity[itemsTable$ItemName == drinkQuantity$Drink[i]])
}

ggplot(drinkQuantity, aes(x = reorder(drinkQuantity$Drink, -drinkQuantity$Quantity), y = drinkQuantity$Quantity)) + 
  geom_bar(stat = "identity", colour = rainbow(10)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Top Drink Quantity") +
  labs(x="Drink Name",y="Drink Quantity")
```

![Drink Quantity](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/2/DrinkQuantity.png)

### 5. Top 10 Item Type
Add an item type column to goods.csv:
```r
indexToType <- function(ItemIndex) {
  goods$ItemType[ItemIndex + 1]
}
itemsTable['itemType'] <- as.character(0)
itemsTable$ItemType <- sapply(itemsTable$ItemIndex, indexToType)
```

Get top 10 item type sold and plot them:
```r
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
```

![Top 10 Item Type](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/2/Top10ItemTypeSold.png)

### 6. Top 10 Tart Type
Get top 10 tart type and plot them:
```r
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
```

![Top 10 Tart Type](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/2/Top10TartSold.png)

## For Apriori to Work
```r
receiptBinary <- as.matrix(receiptBinary)
```

## Decisions
### Support
The support chosen for each case of association rule mining was chosen by testing. It was found that certain values, mostly ranging from 0.02 to 0.03 yielded the most suitable number of rules. For instance, 86 is too many rules for a bakery to utilize in the creation of different packages. Instead, 19 might be a more viable number of packages (derived from the association rules). Incidentally, when the support is increased, a lesser number of rules is generated and this gives too few an association rule. Thus, the support is adjusted to cater to this.

### The minimum length (minlen)
The minimum length was set to 2 for all cases of association rule mining. This is because in order for an association to happen, there must be at least one antecedent and one consequence. Incidentally, is found that most rules have a size of two and bakeries usually bundle items in pairs (twos). Additionally, the confidence for rules of size 2 are higher, giving a better assurance. Therefore we find 2 to be the most suitable.

### Confidence
The confidence values chosen are quite varied. This is due to a the quantity and support of certain items. To elucidate further, the quantity of coffee and tarts are often comparably huge, making the support of the item significantly higher than other items such as cake. (Logically, there are more tarts because they are smaller, and can be ordered in larger amounts). In light of this, the confidence has to be adjusted to take this into account. If the quantity of an item is large, then the confidence has to be set lower since the other items will be "cut-off" from the rules because their occurrence is less. Another phenomenon, there are items sets that have a substantial occurrence (support), but a low confidence because the antecedent of the rule may have a high occurrence.

### Attributes to Ignore
As shown in pre-processing, we remove the receipts' index because they are not useful in association rule mining.
Case in point, the quantity is not considered in the mining itself. The quantity is used to plot a graph to visualize highest sold items.

It is dropped and not considered in the rule mining, since we do not consider it important in the determination of packages. To understand this, there is the analogy of buying cake and tarts from a bakery. If one were to buy a piece of cake (he/she may not buy the full cake which has a quantity of 1), also he/she will most probably not buy only 1 tart from the bakery. Instead, a jar of tarts is bought. What is important in this transaction, is that the customer bought the tarts together with the cake, and not so much the quantity bought.

The price is also ignored, since the most important insight is to see which items are bought together. The price of the items bought together at this point is irrelevant, however in the future this feature can be explored. 