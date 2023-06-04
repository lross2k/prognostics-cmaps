.FormatSplit <- function(data, index, col.name) {
  res <- as.data.frame(data[index])
  names(res) <- col.name
  return(res)
}

.CalcInsignificance <- function(dataFrame, rowName) {
  res <- data.frame(as.list(apply(dataFrame, 2, (function(col) 
    sum(quantile(col))/(quantile(col)[5]*5)))))
  row.names(res) <- c(rowName)
  return(res)
}

.FilterInsignificance <- function(sig, criteria) {
  res <- apply(sig, 2, (function(col) min(col) > criteria))
  res <- sig[,- as.array(which(res == "FALSE", arr.ind = FALSE))]
  return(res)
}

.GetInsignificance <- function(Data_1, Data_2, Data_3, 
                              Data_4, Data_5, Data_6,
                              criteria) {
  res <- .CalcInsignificance(Data_1[-c(1:5)], "Subset_1")
  res <- rbind(res, .CalcInsignificance(Data_2[-c(1:5)], "Subset_2"))
  res <- rbind(res, .CalcInsignificance(Data_3[-c(1:5)], "Subset_3"))
  res <- rbind(res, .CalcInsignificance(Data_4[-c(1:5)], "Subset_4"))
  res <- rbind(res, .CalcInsignificance(Data_5[-c(1:5)], "Subset_5"))
  res <- rbind(res, .CalcInsignificance(Data_6[-c(1:5)], "Subset_6"))
  res <- .FilterInsignificance(res, criteria)
  return(res)
}

.RemoveByInsignificance <- function(insig, df) {
  res <- df[,-apply(as.array(names(insig)), 1, (function(name,df) 
    grep(paste("^",name,"$",sep=""), colnames(df))), df)]
  return(res)
}
