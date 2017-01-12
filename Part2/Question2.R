# Question 2 - Dataset Descriptions

## Read Dataset
# Read 1000-out1.csv
receiptSparse <- read.csv("1000-out1.csv", stringsAsFactors = F, header = F) # R will read the columns incorrectly
dim(receiptSparse) # [1] 1048    7

# Read 1000-out2.csv
receiptBinary <- read.csv("1000-out2.csv", stringsAsFactors = F, header = F)
dim(receiptBinary) # [1] 1000   51

# Read 1000i.csv
itemsTable <- read.csv("1000i.csv", stringsAsFactors = F, header = F)
dim(itemsTable) # [1] 3538    3

## Pre-processing
# Read the dataset with correct number of columns.
receiptSparse <- read.csv("1000-out1.csv", stringsAsFactors = T, header = F, col.names = c("ReceiptNo.", "Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8"))
dim(receiptSparse) # [1] 1000    9

# Add headers to columns in dataset.
colnames(receiptBinary) <- c("ReceiptIndex", "ChocolateCake", "LemonCake", "CasinoCake", "OperaCake", "StrawberryCake", "TruffleCake", "ChocolateEclair", "CoffeeEclair", "VanillaEclair", "NapoleonCake", "AlmondTart", "ApplePie", "AppleTart", "ApricotTart", "BerryTart", "BlackberryTart", "BlueberryTart", "ChocolateTart", "CherryTart", "LemonTart", "PecanTart", "GanacheCookie", "GongolaisCookie", "RaspberryCookie", "LemonCookie", "ChocolateMeringue", "VanillaMeringue", "MarzipanCookie", "TuileCookie", "WalnutCookie", "AlmondCroissant", "AppleCroissant", "ApricotCroissant", "CheeseCroissant", "ChocolateCroissant", "ApricotDanish", "AppleDanish", "AlmondTwist", "AlmondBearClaw", "BlueberryDanish", "LemonLemonade", "RaspberryLemonade", "OrangeJuie", "GreenTea", "BottledWater", "HotCoffee", "ChocolateCoffee", "VanillaFrappuccino", "CherrySoda", "SingleEspresso")

# Add headers to columns in dataset.
colnames(itemsTable) <- c("ReceiptIndex", "ItemQuantity", "ItemIndex")