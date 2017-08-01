#reads in a .Rdata file containing a list of genefamiles
#load('~/summer2017/gfcode.Rdata')

#needs a list of each organism and all genes belonging to that organism

# command I used to format filtere blast table in vim was 
#        /||[A-Za-z0-9\._\/=\-\,():\[\]+]\+|\(|[A-Za-z0-9\.]\+\t\)
#        :%s//\t\1/g

rm(list=ls()) #removes all objects in current R environment

args=commandArgs(trailingOnly=TRUE)
# args = [path to protein list, path to genefamilies.Rdata]
# args[1] = '~/summer2017/bacillusProteinList'
# args[2] = '~/summer2017/bacillusgfcode.Rdata'

#--------------------------Setting Up Col values (organisms)----------------
path=toString(args[1]) #path to dir that contians list of files, each name is an accession # and thefile contains all the protein IDs associated with the organism

file.names <- dir(path, pattern='.prots') #gets all file names (which are accession #s ) in path
orgenes <- data.frame() 
for (i in 1:length(file.names)){
    name <-toString(gsub(".prots$","",file.names[i])) #strips the .prots from the filename
    orgenes <- c(orgenes,assign(name,read.table(paste(path,toString(file.names[i]), sep=''), header=FALSE))) #creates a variable whose name is the acc# and which contains a list of all the protIDs for that acc#
}  
#---------------------------------------------------------------------------

#--------------------------Setting Up Row Values (genefams)-----------------
#all the hard work was done in the famcreator.R code, which create the genefamilies and is loaded into the session
load(args[2])

#---------------------------------------------------------------------------

#-------------------------Building Presence/Absence Matrix------------------

presenceAbsnce <- matrix(2,nrow=length(orgenes), ncol=length(gnamfam)) #initializes a matrix full of 2's, if there is an error, will show up as 2, not 1 or 0 in final matrix

colnames(presenceAbsence) <- colnames(presenceAbsence, do.NULL=FALSE, prefix="genefam") #set colum names too be genefam1, genefam2 etc. for readability

rnams <- list()
for (i in 1:length(file.names)){
    rnams <-c(rnams,toString(gsub(".prots$","",file.names[i]))) # creates a list of accession numbers read into R in part one
}

rownames(presenceAbsence) <- rnams # set the row names of the matrix to be the accession numbers of the orgnisms

for (fam in 1:length(gnamfam)){ # for each gene family
    for (org in 1:length(orgenes)){ # for each organism
        numberOfMatches<- 0 # number of genes in organism that are also in gene family
        for (gene in 1:length(orgenes[[org]])){ # for each gene (protein ID) in the organism
            if (as.character(orgenes[[org]][gene]) %in% gnamfam[[fam]]){ # if the gene is in the current family
                numberOfMatches<- i+1 # increment
            }
        }
        if (numberOfMatches== 0) { # if no genes are found in the current family
            presenceAbsence[org,fam] <- 0   
        } else { # if >1 genes are founf in the current family
            presenceAbsence[org,fam] <- 1
        }
    }
}





