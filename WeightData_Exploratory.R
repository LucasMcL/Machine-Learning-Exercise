## This script contains exploratory analysis of the Weight Lifting Exercise Dataset
## Code from here will be used to generate the report for the Practical Machine Learning

# Load in data; save finalTest data and split other data into training and Test groups
finalTest <- read.csv("./pml-testing.csv")
data <- read.csv("./pml-training.csv")
names <- names(finalTest[, colSums(is.na(finalTest)) == 0])
rawData <- data
data <- data[, c(names[-length(names)], "classe")] #discard summary statistics
data <- data[, -1:-7] #discard names, timestamps, window info

inTrain <- createDataPartition(data$classe, p = 0.7, list = F)
bigTraining <- data[inTrain, ]
testing <- data[-inTrain, ]

inTrain <- createDataPartition(bigTraining$classe, p = 0.7, list = F)
training <- bigTraining[inTrain, ]
cv <- bigTraining[-inTrain, ]

# for (i in 1:13){
#   hist(training[, i], main = names(training)[i])
# }