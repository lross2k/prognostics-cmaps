Data <- read.csv("train_data.csv")
col.name <- names(Data)

tmp <- split(Data, cut(Data$Height, c(-5,5,15,24,30,40,45)))
Data_1 <- as.data.frame(tmp[1])
Data_2 <- as.data.frame(tmp[2])
Data_3 <- as.data.frame(tmp[3])
Data_4 <- as.data.frame(tmp[4])
Data_5 <- as.data.frame(tmp[5])
Data_6 <- as.data.frame(tmp[6])
rm(tmp)
names(Data_1) <- col.name
names(Data_2) <- col.name
names(Data_3) <- col.name
names(Data_4) <- col.name
names(Data_5) <- col.name
names(Data_6) <- col.name

GetInsignificance <- function(dataFrame, rowName) {
  res <- data.frame(as.list(apply(dataFrame, 2, (function(col) sum(quantile(col))/(quantile(col)[5]*5)))))
  row.names(res) <- c(rowName)
  return(res)
}

insig <- GetInsignificance(Data_1[-c(1:5)], "Subset_1")
insig <- rbind(insig, GetInsignificance(Data_2[-c(1:5)], "Subset_2"))
insig <- rbind(insig, GetInsignificance(Data_3[-c(1:5)], "Subset_3"))
insig <- rbind(insig, GetInsignificance(Data_4[-c(1:5)], "Subset_4"))
insig <- rbind(insig, GetInsignificance(Data_5[-c(1:5)], "Subset_5"))
insig <- rbind(insig, GetInsignificance(Data_6[-c(1:5)], "Subset_6"))

FilterInsignificance <- function(sig, criteria) {
  res <- apply(sig, 2, (function(col) min(col) > criteria))
  res <- sig[,- as.array(which(res == "FALSE", arr.ind = FALSE))]
  return(res)
}

insig <- FilterInsignificance(insig, 0.988)

RemoveByInsignificance <- function(insig,df) {
  res <- df[,-apply(as.array(names(insig)), 1, (function(name,df) 
                    grep(paste("^",name,"$",sep=""), colnames(df))), df)]
  return(res)
}

Data_1 <- RemoveByInsignificance(insig, Data_1)
Data_2 <- RemoveByInsignificance(insig, Data_2)
Data_3 <- RemoveByInsignificance(insig, Data_3)
Data_4 <- RemoveByInsignificance(insig, Data_4)
Data_5 <- RemoveByInsignificance(insig, Data_5)
Data_6 <- RemoveByInsignificance(insig, Data_6)

TransformDecreasing <- function(col) {
  if (col[length(col)] < col[1]) {
    col <- rev(col)
  }
  return(col)
}

FormatMotor <- function(df) {
  df[,-(1:5)] <- apply(df[,-(1:5)], 2, TransformDecreasing)
  df[,-c(1:5)] <- apply(df[,-c(1:5)], 2, (function(col) 
                         predict(loess(col~df$Cycle))))
  df <- data.frame(apply(df, 2, (function(col) col/max(col))))
  return(df)
}

tmp <- data.frame(as.list(split(Data_1, Data_1$Motor)[260]))
names(tmp) <- names(Data_1)
tmp <- FormatMotor(tmp)

source('plotting.R')
PlotSensors(tmp, 'motor260.png')
