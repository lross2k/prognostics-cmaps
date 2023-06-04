# Function for plotting the sensor data
.PlotSensors  <- function(tmp, file.name) {
  png(file=file.name, width=1280, height=720)
  par(mar=c(5.1, 4.8, 1.1, 8.1), xpd=TRUE)
  colores = rainbow(500)
  plot(tmp$Cycle, tmp[,6], type='l', col=colores[100], 
       ylim=c(min(tmp[,-(1:5)]),max(tmp[,-(1:5)])), 
       ylab = 'Sensores', xlab = 'Ciclos', lwd=4.0)
  leg <- c(names(tmp)[6])
  col <- c(colores[100])
  for (x in 7:length(tmp)) {
    lines(tmp$Cycle, tmp[,x], type='l', 
          col=colores[x+(30*x)], lwd=4.0)
    leg <- rbind(leg, c(names(tmp)[x]))
    col <- rbind(col, c(colores[x+(30*x)]))
  }
  legend("topright", inset=c(-0.09,0), box.col = "brown",
         bg ="yellow", box.lwd = 2, legend=leg, fill = col)
  dev.off()
}

.TransformDecreasing <- function(col) {
  if (col[length(col)] < col[1]) {
    col <- rev(col)
  }
  return(col)
}

.FormatMotor <- function(df) {
  df[,-c(1:5)] <- apply(df[,-c(1:5)], 2, .TransformDecreasing)
  df[,-c(1:5)] <- apply(df[,-c(1:5)], 2, (function(col) 
                        predict(loess(col~df$Cycle))))
  df[,-c(1:5)] <- data.frame(apply(df[,-c(1:5)], 2, 
                                   (function(col) col/max(col))))
  return(df)
}

TestMotor <- function(df, motor, file.name) {
  tmp <- data.frame(as.list(split(df, df$Motor)[260]))
  names(tmp) <- names(Data_1)
  tmp <- .FormatMotor(tmp)
  
  write.csv2(tmp, paste(file.name, '.csv', sep = ''), row.names = FALSE)
  
  .PlotSensors(tmp, paste(file.name, '.png', sep = ''))
}
