(function(d) for (t in split(d, d$Motor)) {
(function(m) write.csv(m, file=paste("Motor", m[2,2], ".csv", sep = ""), 
                       row.names = FALSE)) (as.data.frame(t))
}) (read.csv('normalized.csv'))
