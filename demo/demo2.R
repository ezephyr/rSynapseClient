# Demo Script for Nov 3, 2011 training session
# 
# Author: Matt Furia
###############################################################################
## load the synapse client and login
library(synapseClient)
library(affy)

###############
## Section 1: Setup a project in Synapse
###############

## log in
synapseLogin()

## set up a project
myName <- <your name>
projName <- sprintf("%ss Curation Project %s", myName, as.character(gsub("-",".",Sys.Date())))

## create a project object using it's constructor. The
## list contains name-value pairs of properties that should
## be added to the project. See help documentation for details
## on the properties that can be set. For projects, only name is
## required
myProj <- createEntity(Project(list(name=projName)))

## create a dataset 
myStudy <- createEntity(Study(list(name="my Study", parentId=propertyValue(myProj, "id"))))

## view the dataset on the web to add a description
onWeb(myStudy)

## refresh the local copy of myStudy
myStudy <- getEntity(myStudy)


################
## Section 2: Working with data
################

## download a metageo expression data object
geoEntityId <- "syn263418"
expr <- loadEntity(geoEntityId)

##inspect the contents
expr
names(expr)
names(expr$objects)

## write the pm values to a text file
### write.table(pm(expr$objects$expression[["HG-U133A"]]), file="pm.txt", sep="\t", quote=F, row.names=F)
write.table(expr$objects$expression, file="pm.txt", sep="\t", quote=F, row.names=F)

## create a new expression layer
myExpr <- createEntity(ExpressionData(list(name="curated expression", parentId = propertyValue(myStudy, "id"))))

## add an annotation specifying the data format
annotValue(myExpr, "format") <- "sageBioCurated"

## add the pm data file to the entity
myExpr <- addFile(myExpr, "pm.txt", path="GSE10024/expression/affymetrix")

## store the data
myExpr <- storeEntity(myExpr)


## create a heatmap of some features and push it to Synapse
## TBD:  Adding 'attachments' from the R client is not yet implemented


##############
## Section 3: Code entities
##############

## create a code entity
plotCode <- Code(list(name="ggheat", parentId=propertyValue(myProj,"id")))

## add code to the entity:
## myHeatMap <- function(x){
##	heatmap(x, main="This is my heatmap")
##}
plotCode <- edit(plotCode)

## source the code file
plotCode <- loadEntity(plotCode)

## show the code entity
plotCode

## attach the code entity
attach(plotCode)

## make a plot
myHeatMap(diag(50))

## detach the code entity
detach(plotCode)

## store the code in Synapse
plotCode <- storeEntity(plotCode)










