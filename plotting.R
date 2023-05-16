commandArgs(trailingOnly=TRUE)[1] -> Path
commandArgs(trailingOnly=TRUE)[2] -> Motor

Normalized <- read.csv(paste(Path,"Normalized",Motor,sep=""))
Regression <- read.csv(paste(Path,"Regression",Motor,sep=""))
Original <- read.csv(paste(Path,Motor,sep=""))

names <- c("Height","Mach","Throttle","Sensor1","Sensor2","Sensor3","Sensor4","Sensor5","Sensor6","Sensor7","Sensor8","Sensor9","Sensor10","Sensor11","Sensor12","Sensor13","Sensor14","Sensor15","Sensor16","Sensor17","Sensor18","Sensor19","Sensor20","Sensor21")

for (i in 1:24) { 
  png(file=paste(Path,names[i], ".png", sep=''), width=1280, height=720)
  plot(Original$Cycle, Normalized[,i+2], type="l", col="blue", pch="o")
  lines(Regression[,i+2], col='red', lwd=2)
  dev.off()
}
