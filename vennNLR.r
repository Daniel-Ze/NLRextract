#!/usr/bin/Rscript
#install.packages("gplots")
#install.packages("plyr")
library(gplots)
library(plyr)

# Saving data from bash script to nlrs
input <- commandArgs()

nb <- input[6]
cc <- input[7]
tir <- input[8]
rpw8 <- input[9]
lrr <- input[10]

# Extracting the file path
path <- dirname(nb)

# Extracting directory and file name from path
nb_t <- read.table(nb, header = TRUE)
nb_l <- nb_t$NB.ARC
cc_t <- read.table(cc, header = TRUE)
cc_l <- cc_t$CC
tir_t<- read.table(tir, header = TRUE)
tir_l<- tir_t$TIR
rpw8_t<- read.table(rpw8, header = TRUE)
rpw8_l<- rpw8_t$RPW8
lrr_t <- read.table(lrr, header = TRUE)
lrr_l <- lrr_t$LRR

venn_in <- list(NBARC=nb_l,CC=cc_l,TIR=tir_l,RPW8=rpw8_l,LRR=lrr_l)

pdf("./nlr.venn.pdf")
tmp <- venn(venn_in)
dev.off()

results <- attr(tmp, "intersections")

for(i in 1:length(results)) {
  df <- ldply (results[i], data.frame)
  p<-df[1,1]
  p<-gsub("\\:", "_", p)
  write.table(df, file = paste0(path,"/",p,".protein"), row.names = FALSE,
              col.names = FALSE, sep = "\t", quote = FALSE)
}

write.table(df, file = paste0(path,"/","nlr.prot"),row.names = FALSE,
            col.names = FALSE, sep = "\t", quote = FALSE)
