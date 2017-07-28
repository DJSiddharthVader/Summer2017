load("~/summer2017/GeneFamilyCreation/familygeneextration/NonCRISPR/gfcode1.Rdata")
geneind <- which(unlist(lapply(gnamfam,length))== 10 & unlist(lapply(gfam_unique,length))==10)
#Using gnamfam guarantees 10 genes overall, i.e., no paralogues, etc. 
#We are going after core genes here.
#However, because there could be multiple genes from the same
#genome and the length equal to 10 condition can still be satisfied,
#gfam_unique is also used. This means that 10 unique genes
#from each of the 10 genomes will be found.
no <- 50
geneind[1:no]
genesforalign <- list()
genesforalign_s <- list() #sorted

for(r in 1:length(geneind[1:no])){
  genesforalign[[r]] <- sort(paste(gfam[[geneind[r]]],gnamfam[[geneind[r]]],sep="_cds_"))
}
genesforalign_s <- lapply(genesforalign, sort)
genesmat <- matrix(unlist(genesforalign_s[1:no]),10,no,byrow=F)

for(l in 1:ncol(genesmat)){
  write.table(genesmat[,l], file=paste("Gfagenome_ind_", l, sep = ""),
              sep="\n",quote=FALSE,row.names=FALSE,col.names=FALSE)
}

################################################################################################
#load("~/summer2017/GeneFamilyCreation/familygeneextration/CRISPR/gfcode3.Rdata")
#no <- 50
#genidSID <- NULL
#for(x in 1:no){
#    for(y in 1:length(gfam[[x]])){
#        genidSID <- c(genidSID, gfam[[x]][y] == gfam_unique[[x]][y])
#    }
#}
#genidSID <- which(genidSID)
#
#SIDgenesforalign <- list()
#SIDgenesforalign_s <- list() #sorted
#
#for(r in 1:no){
#  SIDgenesforalign[[r]] <- sort(paste(gfam[[genidSID[r]]],gnamfam[[genidSID[r]]],sep="_cds_"))
#}
#
#
#
#SIDgenesforalign_s <- lapply(SIDgenesforalign, sort)
#SIDgenesmat <- matrix(unlist(SIDgenesforalign_s),176,5,byrow=F)
#
#for(l in 1:ncol(SIDgenesmat)){
#  write.table(SIDgenesmat[,l], file=paste("Gfagenome_ind_", l, sep = ""),
#              sep="\n",quote=FALSE,row.names=FALSE,col.names=FALSE)
#}
#
