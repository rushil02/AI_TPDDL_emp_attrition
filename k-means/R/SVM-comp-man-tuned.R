library(e1071)

clean_qual_data_mod <- function(x){
  if (x == 'Yes'){
    x <- 1
  }
  else if(x == 'No'){
    x <- 0
  }
  else{
    
    #stop("ERROR-1")
  }
  return(x)
}

cleaned_data_te <- subset(data_main, select=-c(EmployeeCount, EmployeeNumber, Over18, StandardHours))

i = 1
for(xx in cleaned_data_te$Attrition){
  cleaned_data_te$Attrition[i] <- clean_qual_data_mod(xx)
  i = i + 1
}

index <- 1:nrow(cleaned_data_te)
testindex <- sample(index, trunc(length(index)/3))
testset <- cleaned_data_te[testindex,]
trainset <- cleaned_data_te[-testindex,]

svm.model <- svm(factor(Attrition) ~ ., data = trainset, cost = 1000, gamma = 0.99)


svm.pred <- predict(svm.model, testset[,-2])
table(pred = svm.pred, true = testset[,2])

summary(svm.model)
mean(svm.pred==testset[,2])

#tuned <- tune(svm, factor(Attrition) ~ ., data = trainset, kernel="radial", ranges = list(cost=c(0.001, 0.01, 0.1, 10, 100, 1000)))
