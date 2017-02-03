# 1. Exploratory Data Analysis
The dataset chosen is from Kaggle, provided by Otto Group. The dataset contains 93 features which for more than 200, 000 products, separated into train and test set. Here, we only focus on the train set because the target of classification is provided for accuracy checking. The train set will be subset into training set and testing set with ratio 7:3.

## 1.1 Loading Required Library
```r
library(ggplot2) # ggplot
library(rpart) # rpart, printcp, prune
library(e1071) # naiveBayes
library(nnet) # nnet
library(caret) # confusionMatrix
library(pROC) # multiclass.roc
library(devtools) # source_url
```

## 1.2 Preparation Of Data
```r
# Read dataset
dataset <- read.csv(file = "dataset/train.csv", header = TRUE, stringsAsFactors = FALSE)

# Dimension of train set:
dim(dataset) # 61878    95

# Content of train set:
dataset[1:6,1:5]
```

## 1.3 Exploratory Plots
### 1.3.1 Importance of features
```r
featureImpTrain <- data.frame(features = colnames(dataset)[1:93], count = colSums((dataset)[1:93]))
ggplot(featureImpTrain, aes(x = reorder(features, count), y = count)) + 
  geom_bar(stat = "identity", fill='red', color="darkred") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Importance of Features") +
  labs(x = "Feature Counts", y = "Features") +
  coord_flip()
```

![Importance of Features](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part3/Images/featureImportance.png)

### 1.3.2 Count of each target
```r
target <- table(dataset$target)
target <- data.frame(target)
ggplot(target, aes(x = Var1, y = Freq)) + 
  geom_bar(stat = "identity", fill = rainbow(9)) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  ggtitle("Targets Count") +
  labs(x = "Target", y = "Counts")
```

![Count of Each Target](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part3/Images/targetCount.png)

# 2. Pre-processing
We remove id column because it is not a feature. Since the `test.csv` provided does not have target column, so we are unable to verify classification results. Thus, we split the `train.csv` into training set and test set with a ratio of 70:30.
```r
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
```

# 3. Choice of Performance Measures
We will use accuracy, true positive rate (TPR) / sensitivity, and true negative rate (TNR) / specificity.

Accuracy can be used to identify the percentage of correct predictions.

TPR can be used to identify how many observations are correctly predicted as *true* in a particular class (`target` column in our case). E.g. When the observations are labeled as `Class_1`, how many observations of the classification model are correctly labeled as `Class_1`.

TNR can be used to identify how many observation are correctly predicted as *false* in a particular class (`target` column in our case). E.g. When the observations are *not* labeled as `Class_1`, how many observations of the classification model are correctly *not* labeled as `Class_1`.

# 4. Performance of Classifiers
## 4.1 Decision Tree

### 4.1.1 Decision Tree without Pruning
```r
# Build model
dt.model <- rpart(formula = target~., data = train, method = "class")

# Visualise model
plot(dt.model); text(dt.model)
```

![Tree Before Prune](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part3/Images/treeBeforePrune.png)

```r
# Predict without pruning
dt.predict <- predict(dt.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(dt.predict, test$target)
# Accuracy : 0.613 
```

Confusion Matrix:
```
          Reference
Prediction Class_1 Class_2 Class_3 Class_4 Class_5 Class_6 Class_7 Class_8 Class_9
   Class_1       0       0       0       0       0       0       0       0       0
   Class_2     131    4416    2169     767      16     228     467     237     389
   Class_3       0       0       0       0       0       0       0       0       0
   Class_4       0       0       0       0       0       0       0       0       0
   Class_5       0      48      56      10     744       5      11       4       6
   Class_6      31       8       4      23       0    3499      43     112      58
   Class_7       0       0       0       0       0       0       0       0       0
   Class_8     283     340     163      59      44     433     293    2171     489
   Class_9     118      20       7       3       0      40      19      51     549
```

### 4.1.2 Decision Tree with Pruning
```r
# Cost-complexity pruning
printcp(x = dt.model)
```

CP table:

```
        CP nsplit rel error  xerror      xstd
1 0.145547      0   1.00000 1.00000 0.0028530
2 0.094304      1   0.85445 0.85445 0.0031346
3 0.056551      2   0.76015 0.76015 0.0032244
4 0.015223      4   0.64705 0.64751 0.0032465
5 0.010336     10   0.53413 0.53191 0.0031745
6 0.010000     11   0.52379 0.53191 0.0031745
```

```r
# Get CP with lowest xerror
opt <- which.min(dt.model$cptable[, 'xerror'])
cp <- dt.model$cptable[opt, 'CP']

# Prune tree
dt.pruned.model <- prune(tree = dt.model, cp = cp)

# Visualise pruned tree
plot(dt.pruned.model); text(dt.pruned.model)
```

![Tree After Prune](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part3/Images/treeAfterPrune.png)

```r
# Predict with pruning
dt.pruned.predict <- predict(dt.pruned.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(dt.pruned.predict, test$target)
# Accuracy : 0.6059
```

Confusion Matrix:
```
          Reference
Prediction Class_1 Class_2 Class_3 Class_4 Class_5 Class_6 Class_7 Class_8 Class_9
   Class_1       0       0       0       0       0       0       0       0       0
   Class_2     152    4420    2170     768      16     232     471     241     525
   Class_3       0       0       0       0       0       0       0       0       0
   Class_4       0       0       0       0       0       0       0       0       0
   Class_5       0      48      56      10     744       5      11       4       6
   Class_6      31       8       4      23       0    3499      43     112      58
   Class_7       0       0       0       0       0       0       0       0       0
   Class_8     283     340     163      59      44     433     293    2171     489
   Class_9      97      16       6       2       0      36      15      47     413
```

## 4.2 Naive Bayes
```r
# Build model
nb.model <- naiveBayes(formula = target~., data = train, type = "class")

# Predict
nb.predict <- predict(nb.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(nb.predict, test$target)
# Accuracy : 0.5852
```

Confusion Matrix:
```
          Reference
Prediction Class_1 Class_2 Class_3 Class_4 Class_5 Class_6 Class_7 Class_8 Class_9
   Class_1     179      17       5       0       1     143      37     447      59
   Class_2      46    3228    1181     308      29      63      98     106      91
   Class_3      22     467     603      36       4     113     111     121      28
   Class_4      23     513     327     406       2     235      84      18      43
   Class_5      50     484     159      83     765     161      46     186     123
   Class_6      16       4       3       6       0    3128      31      89      33
   Class_7      24      81      94      17       1     125     395     213      20
   Class_8      18      15      13       1       0      60      16    1096      31
   Class_9     185      23      14       5       2     177      15     299    1063
```

## 4.3 Artificial Neural Networks (ANN)
```r
# Build model
ann.model <- nnet(target~., train, size = 9, maxit = 2160)
```

The number of iteration is first set to 10000 and being tested until the result is converged (at iteration 2160).

```
...
...
iter2100 value 23955.203447
iter2110 value 23955.103075
iter2120 value 23955.056588
iter2130 value 23954.970567
iter2140 value 23954.961361
iter2150 value 23954.950169
iter2160 value 23954.884633
final  value 23954.882802 
converged
```

```r
# Plot neural net
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(ann.model)

# Predict
ann.predict <- predict(ann.model, test[1:93], type = "class")

# Confusion Matrix
confusionMatrix(ann.predict, test$target)
# Accuracy : 0.7672
```

Confusion Matrix:
```
          Reference
Prediction Class_1 Class_2 Class_3 Class_4 Class_5 Class_6 Class_7 Class_8 Class_9
   Class_1     232       5       2       1       2      27      15      60      60
   Class_2      17    3853    1262     355      21      42      81      23      22
   Class_3       3     805    1023     144       1       6      89      21       3
   Class_4       0      83      43     327       0      12      14       0       1
   Class_5       3      15       2       6     772       0       7       4       0
   Class_6      47      11       6      20       0    3897      51      66      50
   Class_7      25      38      45       7       1      66     531      33       7
   Class_8     101       7       8       1       2      81      38    2320      61
   Class_9     135      15       8       1       5      74       7      48    1287
```

```r
ann.predict2 <- predict(ann.model, test[1:93], type="raw")
multi.class <- multiclass.roc(test$target, ann.predict2[,1])
auc(multi.class)
```

```
Multi-class area under the curve: 0.8152
```

## 4.4 Comparison
### 4.4.1 Accuracy
Classifier | Accuracy |
--- | --- | ---
Decision Tree without Pruning | 0.613 |
Decision Tree with Pruning | 0.6059 |
Naive Bayes | 0.5852 |
ANN | 0.7672 |

### 4.4.2 True Positive Rate (TPR) / Sensitivity
Classifier \ Class | Class_1 | Class_2 | Class_3 | Class_4 | Class_5 | Class_6 | Class_7 | Class_8 | Class_9
--- | --- | --- | --- | --- | --- | --- | --- | --- | ---
Decision Tree without Pruning | 0.00000 | 0.9139 | 0.0000 | 0.00000 | 0.92537 | 0.8321 | 0.00000 | 0.8431 | 0.36821
Decision Tree with Pruning | 0.00000 | 0.9147 | 0.0000 | 0.00000 | 0.92537 | 0.8321 | 0.00000 | 0.8431 | 0.27700
Naive Bayes | 0.317940 | 0.6680 | 0.25135 | 0.47100 | 0.95149 | 0.7439 | 0.47419 | 0.42563 | 0.71294
ANN | 0.41208 | 0.7974 | 0.42643 | 0.37935 | 0.96020 | 0.9268 | 0.63745 | 0.9010 | 0.86318

## 5. Suggestions as to why the classifiers behave differently
Overall, accuracy is not so high as the training set is not large enough. 

The features provided are not enough, e.g. a product may have only two features to be classified.

ANN perform the best but it requires a lot of time to train. ANN has high tolerance to incomplete data, as in observations with less features. To improve ANN, more hidden layers should be added.

Naive Bayes perform the worst because it assumes independence between the features. However, it is the fastest among the classifiers.

Decision Tree performs significantly better than Naive Bayes, and worse then ANN. Pruning when cp = 0.010336 causes accuracy to drop, our guess is that overpruning has occurred. The advantage to this algorithm is that it is fast  compared to the neural nets and it's results and plot are easily interpreted. To improve, Random Forest can be used.