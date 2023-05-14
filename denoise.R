read.csv('Motor1.csv') -> Data
dependent <- c(1,5,6,7,12,20,21)
for (i in dependent) {
  Data[i+6] + 1 - Data$Height -> Data[i+6]
  Data[i+6] / max(Data[i+6]) -> Data[i+6]
}
write.csv(Data, 'DeNoisedMotor1.csv', row.names = FALSE)
