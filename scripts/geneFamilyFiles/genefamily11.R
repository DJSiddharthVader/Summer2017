## = Athena Comments
# = Sid Comments
# * blast query is the organism in the left most collum of the blast file, the subject is in the middle of the file
rm(list=ls()) # rm all current objects in R data space
ptm <- proc.time() # gets currents time elapsed, for timing purposes

args = commandArgs(trailingOnly=TRUE)
# args is [allsvallblastp.file, listofgenes.file, out.Rdata] 
if (length(args) < 3){
    stop("missing an argument, need: 1)blastfile 2)listofgenes 3) out.Rdata file name")
}

args[3] <- trimws(toString(args[3]))

y <- as.matrix(read.table(args[1])) # reads allvsall blastp as a matrix 
taxanames <- attr(table(y[,1]), "dimnames")[[1]] ##for genefamilycomplete2.R # gets a list of all the unique organism accession numbers used as blast queries
y[, 1] = paste(y[, 1], y[, 2], sep=" ") # concatenates the protein ID and the organism Accnum for the query organism into one colum
y[, 7] = paste(y[, 7], y[, 8], sep=" ") # does the same thing for the subjects organism

gfnames <- vector(mode = "list", length = length(y[, 1])) # creates a list of null values the length of y
gfind <- 1
gfnames[[gfind]]    <- y[1, 1] <- #puts organismId,proteinID of the first entry into gfnames
##the first query initializes the first component of the list
rvers <- as.character(getRversion()) # returns what version of R is being used

for(i in 1:nrow(y)){
  if(i %% 5000 == 0){
      cat(i, "\n") # adds a bunch of whitespace to the protID if the protID is the 5000 entry in the list ( or a multiple of 5000)
  }
  gene <- y[i, 1] # sets gene to be the query protID currently being used in the loop
  genehit <- y[i, 7] # sets genehit to be the corresponding subject protID blast hit from the protID set in gene
  if(!compareVersion(rvers, "3.2.0") < 0) { # if false, then 3.2.0 is later than the R version being used
    sgfl <- lengths(gfnames[1:gfind]) ##lengths does the same thing as ##sapply(gfnames[1:gfind], length). Check ?lengths for lists.
  } else {
    sgfl <- sapply(gfnames[1:gfind], length)# return a vector containing the length of each element in gfnames (gfnames is a list)
  }
  ungf <- unlist(gfnames[1:gfind], use.names = FALSE) # creates a copy of gfnames that is a vector, not a list
  s <- seq_along(gfnames[1:gfind]) # creates a vector of ints the length if gfnames[1:gfnames] i.e. seq_along(list[1:10]) -> [1, 2, 3, 4 ... 10]

  le  <- rep(s, sgfl)[match(gene, ungf)] #
  ##le is the gene family number (if any) that gene already is known to belong to
  gle <- rep(s, sgfl)[match(genehit, ungf)]
  ##gle is the gene family number (if any) that genehit already is known to belong to.

  if(!is.na(le) & !is.na(gle)){ ##if both le and gle exist
    ind <- grep(genehit, x = y[, 1], fixed = TRUE)
    if(gene %in% y[ind, 7])  ##reciprocal best hit is TRUE
    {
      if(le != gle){ ##if gene and genehit have previously been recorded in different gene families.
        ##because they are reciprocal best hits, the le and gle gene families need to be merged.
        ##The genefamily (list component) into which the values are merged will also have gene and
        ##genehit. The other component should be assigned NA.
        min_le <- min(le, gle)
        max_le <- max(le, gle)
        gfnames[[min_le]]    <- c(gfnames[[min_le]], c(gene, genehit, gfnames[[max_le]]))
        gfnames[[max_le]]    <- NULL
      } ##else ##if gene and genehit have previously been recorded in the same gene family, nothing is needed
    } ##else ##if reciprocal best hit is not TRUE, nothing is needed as gene is already in le.
  } else if(!is.na(le) & is.na(gle)){ ##if only le exists
    ind <- grep(genehit, x = y[, 1], fixed = TRUE)
    if(gene %in% y[ind, 7])  ##reciprocal hit is TRUE, add genehit to le
    {
      gfnames[[le]]    <- c(gfnames[[le]], genehit)
    }
  } else if(is.na(le) & !is.na(gle)){ ##if only gle exists
    ind <- grep(genehit, x = y[, 1], fixed = TRUE)
    if(gene %in% y[ind, 7])  ##reciprocal hit is TRUE, add gene to gle
    {
      gfnames[[gle]]    <- c(gfnames[[gle]], gene)
    } else { ##reciprocal hit is not TRUE, add gene to a new family.
      gfind               <- gfind + 1 ##add additional gene family
      gfnames[[gfind]]    <- gene ##add gene name
    }
  } else { ##else if(is.na(le) & is.na(gle)) ##would a simple else suffice?
    gfind               <- gfind + 1 ##add additional gene family
    gfnames[[gfind]]    <- gene ##add gene name
  }
}
save.image(args[3])
gfnames           <- gfnames[!unlist(lapply(gfnames, is.null))]
##Remove NULL components if any

gfnames_unique    <- lapply(X = gfnames, FUN = unique)
##Unique names only

allgenes <- as.matrix(read.table(args[2]))
allgenes[, 1] <- paste(allgenes[, 1], allgenes[, 2], sep=" ")
genesnotfound     <- setdiff(allgenes[, 1], y[, 1]) ##compare with y[,1] because every gene in y[,1] will end up in gfnames_unique and genefamily_unique.

##Add in genes that did not meet the gene family criteria

vgnf <- gsub(pattern = " ", replacement = "_cds_", x = genesnotfound, fixed = TRUE)
##vector of names of genes not found as compared to list of all genes.

gnamfam <- list()
gfam <- list()
for(i in 1:length(gfnames_unique)){
  temp_1 <- NULL
  temp_2 <- NULL
  for(j in 1:length(gfnames_unique[[i]])){
    temp <- stringr::str_split_fixed(gfnames_unique[[i]][j], " ", n = 2)
    temp_1 <- c(temp_1, temp[,1])
    temp_2 <- c(temp_2, temp[,2])
  }
  gfam[[i]] <- temp_1 ##taxa names; for the gene family list constructed overall
  gnamfam[[i]] <- temp_2 ##gene names; for the gene family list constructed overall
}
gfam_unique    <- lapply(X = gfam, FUN = unique) ##for genesforalignment_individualgenes
## split_taxa_gene <- lapply(gfnames_unique, function(y){stringr::str_split_fixed(y, " ", n = 2)})
##If there are orthologs from 1 taxa that never
##hit anything from any other species, all the orthologs are checked against
##NR database. Now, orthologs should be in one gene family. So, if any are valid when checked against NR, one row should be added to the gene family matrix with a 1 for this taxa. If more than one are valid, it should still be only 1 row being added. Basically, valid ortholog genes not being hit against the other taxa should only counted as 1 gene family.

pos_singletons <- which(sapply(X = gfam_unique, FUN = length) == 1) # pos_singletons <- [TRUE for x in gfam unique if gfam_unique[x] contains 1 element else FALSE]
##supplement this with singleton genes unique to only one species. This list also includes orthologs unique to a single species.
singletons <- unlist(gfnames_unique[pos_singletons])
singletons_cd <- gsub(pattern = " ", replacement = "_cds_", x = singletons, fixed = TRUE)

genesforNR <- c(vgnf, singletons_cd) ##includes all genes that didn't make the cut

gfnameswosing <- gfnames_unique[-pos_singletons]##gfnames_unique[!unlist(lapply(gfnames_unique, length)==1)]
gfamwosing <- gfam[-pos_singletons]##Without singletons - for genefamilycomplete2
gnamfamwosing <- gnamfam[-pos_singletons]##Without singletons - for genefamilycomplete2

write.table(genesforNR,"genesforNR.txt",quote=FALSE,row.names=FALSE,col.names=FALSE)
timetaken <- proc.time() - ptm
save.image(args[3])
