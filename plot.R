read.csv('Motor260.csv') -> Data
cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
          "#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
          "#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7",
          "#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
dependent <- c(1,5,6,7,12,20,21)
png(file="height-dependent.png", width=1280, height=720)
plot(Data$Cycle, Data$Height, type="l", col="blue", pch="o")
for (i in dependent) { lines(Data$Cycle, Data[,i+6], col=cbp1[i], lty=1) }
dev.off()

independent <- c(2, 3, 4, 8, 9, 10, 11, 13, 15, 16, 17, 18, 19)
png(file="height-independent.png", width=1280, height=720)
plot(Data$Cycle, Data$Height, type="l", col="blue", pch="o")
for (i in independent) { lines(Data$Cycle, Data[,i+6], col=cbp1[i], lty=1) }
dev.off()

for (i in 1:21) { 
  png(file=paste("Sensor", i, ".png", sep=''), width=1280, height=720)
  plot(Data$Cycle, Data[,i+6], type="l", col="blue", pch="o")
  dev.off()
}

for (i in 1:21) { 
  png(file=paste("Sensor", i, ".png", sep=''), width=1280, height=720)
  lo <- loess(Data[,i+6]~Data$Cycle)
  plot(Data$Cycle, Data[,i+6], type="l", col="blue", pch="o")
  lines(predict(lo), col='red', lwd=2)
  dev.off()
}
