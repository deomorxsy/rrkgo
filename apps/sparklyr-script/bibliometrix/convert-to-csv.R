##setwd("path/to/bib-packrat")
##packrat::on("path/to/bib-packrat")

library(dplyr)

load("./computer_TI_clean.Rda")

M <- M[-c(500),]
M <- M[-c(1177),]
M <- M[-c(1177),]
M <- M[-c(3612),]
M <- M[-c(3615),]
M <- M[-c(4611),]

typeof(M)

#df <- data.frame(M)
#typeof(df)


#glimpse(M)
head(M)

write.csv(M, file="./ctc.csv")
