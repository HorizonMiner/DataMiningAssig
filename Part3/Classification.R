# =========================
# Loading Required Libaries
# =========================

library(ggplot2) # ggplot
library(rpart) # rpart, printcp, prune
library(e1071) # naiveBayes
library(nnet) # nnet
library(caret) # confusionMatrix
library(devtools) # source_url

# =========================
# Exploratory Data Analysis
# =========================

# Read dataset
dataset <- read.csv(file = "dataset/train.csv", header = TRUE, stringsAsFactors = FALSE)

# Dimension of train set:
dim(dataset) # 61878    95

# Content of train set:
dataset[1:6,1:5, with =F]

# Importance of features
featureImpTrain <- data.frame(features = colnames(dataset)[1:93], count = colSums((dataset)[1:93]))
ggplot(featureImpTrain, aes(x = reorder(features, count), y = count)) + 
  geom_bar(stat = "identity", fill='red', color="darkred") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Importance of Features") +
  labs(x = "Feature Counts", y = "Features") +
  coord_flip()

# Count of each target
target <- table(dataset$target)
target <- data.frame(target)
ggplot(target, aes(x = Var1, y = Freq)) + 
  geom_bar(stat = "identity", fill = rainbow(9)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Targets Count") +
  labs(x = "Target", y = "Counts")

# =============
# Preprocessing
# =============

# Checking NAs
apply(dataset, 2, function(x) sum(is.na(x))) # 0 for all columns

# Drop id column
dataset <- subset(x = dataset, select = -c(1))

# Convert target as factor
dataset$target <- as.factor(dataset$target)

# Split into training set and test set
set.seed(999)
dataset.sub <- sample(1:nrow(dataset), floor(nrow(dataset) * 0.7))
train <- dataset[dataset.sub,]
test <- dataset[-dataset.sub,]

# Dimension Of data frame 'train':
dim(train) # 43314    94

# Dimension of data frame 'test':
dim(test) # 18564    94

## =============================
## Decision Tree without Pruning
## =============================

# Build model
dt.model <- rpart(formula = target~., data = train, method = "class")

# Visualise model
plot(dt.model); text(dt.model)

# Predict without pruning
dt.predict <- predict(dt.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(dt.predict, test$target)
# Accuracy : 0.613 

## ==========================
## Decision Tree with Pruning
## ==========================

# Cost-complexity pruning
printcp(x = dt.model)

# Get CP with lowest xerror
opt <- which.min(dt.model$cptable[, 'xerror'])
cp <- dt.model$cptable[opt, 'CP']

# Prune tree
dt.pruned.model <- prune(tree = dt.model, cp = cp)

# Visualise pruned tree
plot(dt.pruned.model); text(dt.pruned.model)

# Predict with pruning
dt.pruned.predict <- predict(dt.pruned.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(dt.pruned.predict, test$target)
# Accuracy : 0.6059

# ===========
# Naive Bayes
# ===========

# Build model
nb.model <- naiveBayes(formula = target~., data = train, type = "class")

# Predict
nb.predict <- predict(nb.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(nb.predict, test$target)
# Accuracy : 0.5852

# =========================
# Artificial Neural Network
# =========================

# Build model
ann.model <- nnet(target~., train, size = 9, maxit = 2160)

# Plot neural net
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(ann.model)

# Predict
ann.predict <- predict(ann.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(ann.predict, test$target)
# Accuracy : 0.7672