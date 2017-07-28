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
for (i in 1;length(file.names)){
    name <-toString(gsub(".prots$","",file.names[i])) #strips the .prots from the filename
    orgenes <- c(orgenes,assign(name,read.table(paste(path,toString(file.names[i]), sep=''), header=FALSE))) #creates a variable whose name is the acc# and which contains a list of all the protIDs for that acc#
}  
#---------------------------------------------------------------------------

#--------------------------Setting Up Row Values (genefams)-----------------
#all the hard work was done in the famcreator.R code, which create the genefamilies and is loaded into the session
load(args[2])

#---------------------------------------------------------------------------

#-------------------------Building Presence/Absence Matrix------------------

presenceAbsence <- matrix(2,nrow=length(orgenes), ncol=length(gnamfam)

colnames(presenceAbsence) <- colnames(presenceAbsence, do.NULL=FALSE, prefix="genefam")

rnams <- list()
for (i in 1:length(file.names)){
    rnams <-c(rnams,toString(gsub(".prots$","",file.names[i])))
}
rownames(presenceAbsence) <- rnams

for (fam in 1:length(gnamfam)){
    for (org in 1:length(orgenes)){
        for (gene in 1:length(orgenes[[org]])){
            i <- 0
            if (orgenes[[org]][gene] %in% gnamfam[[fam]]){
                presenceAbsence[org][fam] <- 1
                i <- i+1 
            }
            if (i == 0){
                presenceAbsence[org][fam] <- 0
            }
        }
    }
}





