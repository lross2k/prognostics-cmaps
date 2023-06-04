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
fitting <- data.frame()

for (.x in c(1,130,260)) {
  fitting <- TestMotor(Data_1, .x, fitting, 
                       paste('Subset_1_Regulador_60_Motor_',
                             as.character(.x),sep=''))
  fitting <- TestMotor(Data_2, .x, fitting, 
                       paste('Subset_2_Regulador_100_Motor_',
                             as.character(.x),sep=''))
  fitting <- TestMotor(Data_3, .x, fitting, 
                       paste('Subset_3_Regulador_100_Motor_',
                             as.character(.x),sep=''))
  fitting <- TestMotor(Data_4, .x, fitting, 
                       paste('Subset_4_Regulador_100_Motor_',
                             as.character(.x),sep=''))
  fitting <- TestMotor(Data_5, .x, fitting, 
                       paste('Subset_5_Regulador_100_Motor_',
                             as.character(.x),sep=''))
  fitting <- TestMotor(Data_6, .x, fitting, 
                       paste('Subset_6_Regulador_100_Motor_',
                            as.character(.x),sep=''))
}
#names(fitting) <- c('Rsquared','fact1','fact2','fact3','fact4')
names(fitting) <- c('fact1','fact2','fact3','fact4')

#eq <- quote(mean(fitting$fact1)*x + mean(fitting$fact2)*x^2 + 
#            mean(fitting$fact3)*x^3 + mean(fitting$fact4)*x^4)

print(paste(as.character(mean(fitting$fact1)), '*x + ', 
            as.character(mean(fitting$fact2)), '*x^2 + ',
            as.character(mean(fitting$fact3)), '*x^3 + ', 
            as.character(mean(fitting$fact4)), '*x^4', sep=''))
write.csv2(c(mean(fitting$fact1), mean(fitting$fact2), 
             mean(fitting$fact3), mean(fitting$fact4)),
           'equation.csv', row.names = FALSE)
