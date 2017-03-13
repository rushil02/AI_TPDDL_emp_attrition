library(rpart)
w <- t(svm.model$coefs) %*% svm.model$SV  
w <- apply(w, 2, function(v){sqrt(sum(v^2))})
w <- sort(w, decreasing = T)
print(w)
write.csv(w, file = "factor-weights-2.csv")
