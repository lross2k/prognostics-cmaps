# Pass the name of the CSV file to split the data at Motor column
(function(d) for (t in split(d, d$Motor)) {
(function(m) write.csv(m, file=paste("Motor", m[1,1], ".csv", sep = ""), 
                       row.names = FALSE)) (as.data.frame(t))
}) (read.csv(commandArgs(trailingOnly=TRUE)[1]))
