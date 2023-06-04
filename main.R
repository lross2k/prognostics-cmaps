Data <- read.csv("train_data.csv")
col.name <- names(Data)

source('formatting.R')
tmp <- split(Data, cut(Data$Height, c(-5,5,15,24,30,40,45)))
rm(Data)
Data_1 <- FormatSplit(tmp, 1, col.name)
Data_2 <- FormatSplit(tmp, 2, col.name)
Data_3 <- FormatSplit(tmp, 3, col.name)
Data_4 <- FormatSplit(tmp, 4, col.name)
Data_5 <- FormatSplit(tmp, 5, col.name)
Data_6 <- FormatSplit(tmp, 6, col.name)
rm(tmp)

insig <- GetInsignificance(Data_1, Data_2, Data_3, 
                           Data_4, Data_5, Data_6,
                           0.988)

Data_1 <- RemoveByInsignificance(insig, Data_1)
Data_2 <- RemoveByInsignificance(insig, Data_2)
Data_3 <- RemoveByInsignificance(insig, Data_3)
Data_4 <- RemoveByInsignificance(insig, Data_4)
Data_5 <- RemoveByInsignificance(insig, Data_5)
Data_6 <- RemoveByInsignificance(insig, Data_6)
rm(insig)

source('analysis.R')

for (.x in c(1,130,260)) {
  TestMotor(Data_1, .x, paste('Subset_1_Regulador_60_Motor_',
                             as.character(.x),sep=''))
   # TestMotor(Data_2, .x, paste('Subset_2_Regulador_100_Motor_',
   #                            as.character(.x),sep=''))
   # TestMotor(Data_3, .x, paste('Subset_3_Regulador_100_Motor_',
   #                            as.character(.x),sep=''))
   # TestMotor(Data_4, .x, paste('Subset_4_Regulador_100_Motor_',
   #                            as.character(.x),sep=''))
   # TestMotor(Data_5, .x, paste('Subset_5_Regulador_100_Motor_',
   #                            as.character(.x),sep=''))
   # TestMotor(Data_6, .x, paste('Subset_6_Regulador_100_Motor_',
   #                            as.character(.x),sep=''))
}
