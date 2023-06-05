source('subsetting.R')
ret <- GetSubsets()
Data_1 <- as.data.frame(ret[1])
Data_2 <- as.data.frame(ret[2])
Data_3 <- as.data.frame(ret[3])
Data_4 <- as.data.frame(ret[4])
Data_5 <- as.data.frame(ret[5])
Data_6 <- as.data.frame(ret[6])
rm(ret)

equationData <- read.csv2('equation.csv')
# equation <- quote(equationData[1,1] * x   + equationData[2,1] * x^2 + 
#                   equationData[3,1] * x^3 + equationData[4,1] * x^4)

# equation <- quote(9.869138e-01  * x   + 5.524573e-05 * x^2 + 
#                     -3.327101e-08 * x^3 + 3.277860e-09 * x^4)

equation <- quote(9.869138e-01  * x   + 5.524573e02 * x^2 + 
                    -1.327101e-20 * x^3 + 3.277860e-06 * x^4)

source('analysis.R')
fitting <- list()
for (.x in c(1:260)) {
  fitting <- TestFitting(Data_1, .x, fitting, equation)
  fitting <- TestFitting(Data_2, .x, fitting, equation)
  fitting <- TestFitting(Data_3, .x, fitting, equation)
  fitting <- TestFitting(Data_4, .x, fitting, equation)
  fitting <- TestFitting(Data_5, .x, fitting, equation)
  fitting <- TestFitting(Data_6, .x, fitting, equation)
}

summary(unlist(fitting))
