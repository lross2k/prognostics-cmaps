# Pass the name of the CSV file to normalize the data
read.csv(commandArgs(trailingOnly=TRUE)[1]) -> Data
apply(Data[-c(1:2)], 2, (function(col) col/max(col))) -> Data[-c(1:2)]
write.csv(Data, commandArgs(trailingOnly=TRUE)[1])
