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

clean_qual_data_business_travel <- function(x){
  if (x == 'Travel_Rarely'){
    x <- 1
  }
  else if(x == 'Travel_Frequently'){
    x <- 2
  }
  else if(x =='Non-Travel'){
    x <- 0 
  }
  else {
    #stop("ERROR-1")
  }
  return(x)
}

# Remove columns
cleaned_data_te <- subset(data_main, select=-c(EmployeeCount, EmployeeNumber, Over18, StandardHours, HourlyRate, # Test purposes only -> [\n]
                                               Department, EducationField, Gender, JobRole, MaritalStatus, OverTime))

# Y-val cleaning
i = 1
for(xx in cleaned_data_te$Attrition){
  cleaned_data_te$Attrition[i] <- clean_qual_data_mod(xx)
  i = i + 1
}

# X-val cleaning
# BusinessTravel -> char to val
i = 1
for(xx in cleaned_data_te$BusinessTravel){
  cleaned_data_te$BusinessTravel[i] <- clean_qual_data_business_travel(xx)
  i = i + 1
}

cleaned_data_te[, c(2,3)] <- sapply(cleaned_data_te[, c(2,3)], as.numeric)

# Data Soft normalization
norm_data <- function(colx){
  
  norm_features <- (colx - mean(colx)) / 2*sd(colx)
  return(norm_features)
}

# colx <- cleaned_data_te$Age
# norm_features <- (colx - mean(colx)) / (2*sd(colx))
for (col1 in names(cleaned_data_te)){
  if(col1!="Attrition"){
    cleaned_data_te[[col1]] <- norm_data(cleaned_data_te[[col1]])
  }
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
