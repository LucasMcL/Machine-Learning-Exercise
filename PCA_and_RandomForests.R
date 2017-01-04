# folds <- createFolds(y = bigTraining$class, k = 10, list = T, returnTrain = T)
# for(i in 1:10){}
#   dataFold <- bigTraining[folds[[i]], ]
#   tree <- rpart(classe ~ ., data = dataFold)
#   tree$variable.importance[1:5]
# }

set.seed(123)
rf1 <- randomForest(classe ~ ., data = training, importance = T, ntree = 100)

set.seed(816)
rf2 <- randomForest(classe ~ ., data = training, importance = T, ntree = 200)

preProc <- preProcess(training[, -53], method = "pca") # Build preproc object, excluding outcome variable
trainingPC <- predict(preProc, training[, -53]) # Apply preproc object to training w/o outcome variable
cvPC <- predict(preProc, cv[, -53]) # Apply same object to test or cv set, w/o outcome variable
rf3 <- randomForest(training$classe ~ ., data = trainingPC, importance = T, ntree = 500) # In formula, call outcome variable from original dataset, but use data from PCA dataset

rf4 <- randomForest(classe ~ ., data = bigTraining, ntree = 2000)
confusionMatrix(predict(rf4, testing), testing$classe)

## Final model using all available data
final_rf <- randomForest(classe ~ ., data = data, ntree = 2000)
answers <- as.character(predict(final_rf, finalTest))

## Function to write final predictions into text files
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}