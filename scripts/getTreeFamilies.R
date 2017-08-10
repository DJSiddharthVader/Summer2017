#This code is meant to find all of the gene families that belong to every organism and get 1 protein ID for each of such families

rm(list=ls()) # clears R environment

args=commandArgs(trailingOnly=TRUE) # allows command line args
#args [1] = Rdata file created by createpresenceAbsencemtrix.R

eqs <- function(x,y) if (x==y) x else FALSE
cols <- list()
for (cl in 1:ncol(stest)){
  if (stest[1,cl]==1){
    cols <- c(cols,ifelse(Reduce(eqs,stest[,cl]),cl,FALSE))
  } else {
    cols <- c(cols,FALSE)
  }
}
colresstest <- colnames(stest[unlist(cols),])
