folds <- createFolds(y = bigTraining$class, k = 10, list = T, returnTrain = T)
for(i in 1:10){}
  dataFold <- bigTraining[folds[[i]], ]
  tree <- rpart(classe ~ ., data = dataFold)
  tree$variable.importance[1:5]
}