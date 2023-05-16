# Pass the name of the CSV file to predict the data
Data <- read.csv(commandArgs(trailingOnly=TRUE)[1])
apply(Data[-c(1:2)], 2, (function(col) predict(loess(col~Data$Cycle)))) -> Data[-c(1:2)]
write.csv(Data, commandArgs(trailingOnly=TRUE)[2], row.names = FALSE)
