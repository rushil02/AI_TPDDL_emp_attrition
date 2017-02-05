 library(readxl)

 clean_qual_data <- function(x){
   if (x[2] == 'Yes'){
     x[2] <- 1
   }
   else if(x[2] == 'No'){
     x[2] <- 0
   }
   else{
     
    # stop("ERROR-1")
   }
   return(x)
 }

data_main <- read_excel(paste(dirname(dirname(getwd())),'HR-Employee-Attrition.xlsx', sep="/"))

#false_data = matrix(11:600, ncol = 2) 

cleaned_data<-t(apply(data_main, 1, clean_qual_data))
plot(cleaned_data)