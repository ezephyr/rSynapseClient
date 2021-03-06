# TODO: Add comment
# 
# Author: furia
###############################################################################

setMethod(
  f = "getEntityInstance",
  signature = signature("list"),
  definition = function(entity)
  {
    class <- getClassFromSynapseEntityType(entity$entityType)
    
    ## synapseEntity is the default
    if(is.null(class))
      class <- "SynapseEntity"
    
    if(class == "SynapseEntity"){
      if(!is.null(entity$locations) && length(entity$locations) > 0)
        class <- "SynapseLocationOwnerWithObjects"
    }
    
    ## call the appropriate constructor and pass the list
    ## representation of the entity
    ee <- do.call(class, list(entity = entity))
    ee@synapseWebUrl <- .buildSynapseUrl(propertyValue(ee, "id"))
#    if(!is.null(propertyValue(ee, "locations")))
#      ee <- initialzeEntity(ee)
    
    ee
  }
)


setMethod(
  f = "initialzeEntity",
  signature = "SynapseEntity",
  definition = function(entity){
    entity
  }
)

setMethod(
  f = "initialzeEntity",
  signature = "SynapseLocationOwner",
  definition = function(entity){
    ifun <- getMethod("initialzeEntity", "SynapseEntity")
    entity <- ifun(entity)
    
    ## get the cache url for this entity
    url <- properties(entity)$locations[[1]][['path']]
    if(is.null(url))
      return(entity)
    parsedUrl <- synapseClient:::.ParsedUrl(propertyValue(entity, 'locations')[[1]]['path'])
    destdir <- file.path(synapseCacheDir(), gsub("^/", "", parsedUrl@pathPrefix))
    if(!file.exists(destdir))
      dir.create(destdir, recursive=T)
    destdir <- normalizePath(path.expand(destdir))
    
    ## instantiate the file cache an put the reference in
    ## the archOwner
    fc <- getFileCache(destdir)
    entity@archOwn@fileCache <- fc
    entity
  }
)

setMethod(
  f = "initialzeEntity",
  signature = "SynapseLocationOwnerWithObjects",
  definition = function(entity){
    ifun <- getMethod("initialzeEntity", "SynapseLocationOwner")
    entity <- ifun(entity)
    
    ## instantiate the file cache an put the reference in
    ## the archOwner
    entity@objOwn$fileCache <- entity@archOwn@fileCache
    entity
  }
)