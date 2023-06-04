# Function for plotting the sensor data
PlotSensors  <- function(tmp, file.name) {
  png(file=file.name, width=1280, height=720)
  par(mar=c(5.1, 4.8, 1.1, 8.1), xpd=TRUE)
  colores = rainbow(500)
  plot(tmp$Cycle, tmp[,6], type='l', col=colores[100], 
       ylim=c(min(tmp[,-(1:5)]),max(tmp[,-(1:5)])), ylab = 'Sensores', 
       xlab = 'Ciclos', lwd=4.0)
  leg <- c(names(tmp)[6])
  col <- c(colores[100])
  for (x in 7:length(tmp)) {
    lines(tmp$Cycle, tmp[,x], type='l', col=colores[x+(30*x)], lwd=4.0)
    leg <- rbind(leg, c(names(tmp)[x]))
    col <- rbind(col, c(colores[x+(30*x)]))
  }
  legend("topright", inset=c(-0.09,0), box.col = "brown",
         bg ="yellow", box.lwd = 2, legend=leg, fill = col)
  dev.off()
  return(NULL)
}
