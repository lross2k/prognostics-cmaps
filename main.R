Data <- read.csv("train_data.csv")

Data <- data.frame(apply(Data, 2, rev))

tmp <- split(Data, Data$Throttle)
Data60_1 <- as.data.frame(tmp[1])
Data100 <- as.data.frame(tmp[2])
names(Data60_1) <- names(Data)
names(Data100) <- names(Data)

tmp <- split(Data100, cut(Data100$Height, c(-10,5,15,24,39,55)))
Data100_1 <- as.data.frame(tmp[1])
Data100_2 <- as.data.frame(tmp[2])
Data100_3 <- as.data.frame(tmp[3])
Data100_4 <- as.data.frame(tmp[4])
Data100_5 <- as.data.frame(tmp[5])
rm(tmp, Data100)
names(Data100_1) <- names(Data)
names(Data100_2) <- names(Data)
names(Data100_3) <- names(Data)
names(Data100_4) <- names(Data)
names(Data100_5) <- names(Data)

insignificance <- function(dataFrame, rowName) {
  insig <- data.frame(as.list(apply(dataFrame, 2, (function(col) sum(quantile(col))/(quantile(col)[5]*5)))))
  row.names(insig) <- c(rowName)
  return(insig)
}

Insignificancia <- insignificance(Data100_1[-c(1,2,5)], "60%_1")
Insignificancia <- rbind(Insignificancia, insignificance(Data100_1[-c(1,2,5)], "100%_1"))
Insignificancia <- rbind(Insignificancia, insignificance(Data100_2[-c(1,2,5)], "100%_2"))
Insignificancia <- rbind(Insignificancia, insignificance(Data100_3[-c(1,2,5)], "100%_3"))
Insignificancia <- rbind(Insignificancia, insignificance(Data100_4[-c(1,2,5)], "100%_4"))
Insignificancia <- rbind(Insignificancia, insignificance(Data100_5[-c(1,2,5)], "100%_5"))

filtrar <- function(sig, criterio) {
  tmp <- apply(sig, 2, (function(col) min(col) > criterio))
  return(sig[,- as.array(which(tmp == "FALSE", arr.ind = FALSE))])
}
Insignificancia <- filtrar(Insignificancia,0.988)

remover <- function(insig,df) {
  val <- df[,-apply(as.array(names(insig)), 1, (function(name,df) grep(paste("^",name,"$",sep=""), colnames(df))), df)]
  return(val)
}
Data60_1 <- remover(Insignificancia, Data60_1)
Data100_1 <- remover(Insignificancia, Data100_1)
Data100_2 <- remover(Insignificancia, Data100_2)
Data100_3 <- remover(Insignificancia, Data100_3)
Data100_4 <- remover(Insignificancia, Data100_4)
Data100_5 <- remover(Insignificancia, Data100_5)

getGrowing <- function(col) {
  if (col[length(col)] < col[1]) {
    col <- rev(col)
  }
  return(col)
}

tmp <- data.frame(as.list(split(Data100_1, Data100_1$Motor)[1]))
names(tmp) <- names(Data100_1)
tmp[,-(1:5)] <- apply(tmp[,-(1:5)], 2, getGrowing)
tmp[,-c(1:5)] <- apply(tmp[,-c(1:5)], 2, (function(col) predict(loess(col~tmp$Cycle))))
tmp <- data.frame(apply(tmp, 2, (function(col) col/max(col))))

plot(tmp$Cycle, tmp[,6], type='l', col=colors()[100])
for (x in 7:length(tmp)) {
  lines(tmp$Cycle, tmp[,x], type='l', col=colors()[x+30])
}
