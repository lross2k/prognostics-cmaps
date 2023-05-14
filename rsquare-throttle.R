rsq = function (Data) { df <- as.data.frame(apply(Data[,-c(1:6)], 2, 
     (function (y1,y2) cor(y1,y2)^2), Data$Mach))
      colnames(df) = c('R^2 vs Throttle'); return(df) }
write.csv(rsq(read.csv('Motor1.csv')), "rsquare-throttle.csv")
