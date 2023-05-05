read.csv('train_FD002.csv') -> Data
apply(Data[-c(1:5)], 2, (function(col) col/max(col))) -> Data[-c(1:5)]
write.csv(Data, 'normalized.csv')
