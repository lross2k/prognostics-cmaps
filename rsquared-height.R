rsq = function (Data) { df <- as.data.frame(apply(Data[,-c(1:6)], 2, 
     (function (y1,y2) cor(y1,y2)^2), Data$Height))
      colnames(df) = c('R^2 vs Height'); return(df) }
write.csv(rsq(read.csv('Motor1.csv')), "rsquare-height.csv")
