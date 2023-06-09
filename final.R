equationData <- read.csv2('equation.csv')
equation <- quote(equationData[1,1] * x   + equationData[2,1] * x^2 + 
                  equationData[3,1] * x^3 + equationData[4,1] * x^4)

source('subsetting.R')
ret <- GetSubsets()
Data_1 <- as.data.frame(ret[1])
Data_2 <- as.data.frame(ret[2])
Data_3 <- as.data.frame(ret[3])
Data_4 <- as.data.frame(ret[4])
Data_5 <- as.data.frame(ret[5])
Data_6 <- as.data.frame(ret[6])
rm(ret)

source('analysis.R')
for (.x in c(1,130,260)) {
  FinalPlot(Data_1, .x, paste('Final_1_Regulador_60_Motor_',
                              as.character(.x),sep=''), equation)
  FinalPlot(Data_2, .x, paste('Final_2_Regulador_100_Motor_',
                              as.character(.x),sep=''), equation)
  FinalPlot(Data_3, .x, paste('Final_3_Regulador_100_Motor_',
                              as.character(.x),sep=''), equation)
  FinalPlot(Data_4, .x, paste('Final_4_Regulador_100_Motor_',
                              as.character(.x),sep=''), equation)
  FinalPlot(Data_5, .x, paste('Final_5_Regulador_100_Motor_',
                              as.character(.x),sep=''), equation)
  FinalPlot(Data_6, .x, paste('Final_6_Regulador_100_Motor_',
                              as.character(.x),sep=''), equation)
}
