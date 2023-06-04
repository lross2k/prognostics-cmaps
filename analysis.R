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

.AddExtraCol <- function(df) {
  new <- c()
  for (.x in 1:length(df$Sensor14)) {
    vals <- c(df$Sensor4[.x], df$Sensor15[.x])
    dist <- max(vals) - min(vals)
    new <- rbind(new, min(vals) + dist / 2)
  }
  df$Extra <- new
  return(df)
}

.FormatMotor <- function(df) {
  df[,-c(1:5)] <- apply(df[,-c(1:5)], 2, .TransformDecreasing)
  df[,-c(1:5)] <- apply(df[,-c(1:5)], 2, (function(col) 
                        predict(loess(col~df$Cycle))))
  df[,-c(1:5)] <- data.frame(apply(df[,-c(1:5)], 2, 
                                   (function(col) col/max(col))))
  df <- .AddExtraCol(df)
  return(df)
}

TestMotor <- function(df, motor, fittingSummary, file.name) {
  tmp <- data.frame(as.list(split(df, df$Motor)[motor]))
  names(tmp) <- names(Data_1)
  tmp <- .FormatMotor(tmp)
  tmp <- tmp[-c(6,8,9,10,11,13,14,15,16)]
  fit3 <- lm(Extra~poly(Cycle,3,raw=TRUE), data=tmp)
  tmp$Fitted <- predict(fit3)
  .est <- as.data.frame(summary(fit3)$coefficients)$Estimate
  fittingSummary <- rbind(fittingSummary, 
                          #c(summary(fit3)$adj.r.squared, .est[1],
                            #.est[2], .est[3], .est[4]))
                          c(.est))
  
  # Write data to a CSV file with ; delimiter
  #write.csv2(tmp, paste(file.name, '.csv', sep = ''), 
  #           row.names = FALSE)
  # Plot sensor data vs cycle
  #.PlotSensors(tmp, 
  #             paste(file.name, '.png', sep = ''))
  
  return(fittingSummary)
}
