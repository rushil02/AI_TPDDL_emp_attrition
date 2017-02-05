library(readxl)
library(ggplot2)

data_main <- read_excel(paste(dirname(dirname(getwd())),'HR-Employee-Attrition.xlsx', sep="/"))

for(col1 in names(data_main)){
  for(col2 in names(data_main)){
    if((col1!=col2)&(col1!="Attrition")&(col2!="Attrition")){
      print(c(col1, col2))
      qplot(data_main[[col1]], data_main[[col2]], data = data_main, colour=Attrition, xlab = col1, ylab = col2)
      ggsave(paste(col1,'-', col2,'.png', sep=""), width = 16, height = 9, dpi = 300, path = paste(dirname(getwd()),'pre-plot-data', sep = "/"))
    }
    
  }
}
print("done")
