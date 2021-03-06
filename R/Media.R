### Media entity constructors and methods
### 
### Author: Matthew D. Furia <matt.furia@sagebase.org>
################################################################################
#
#setMethod(
#		f = "Media",
#		signature = "character",
#		definition = function(entity){
#			getEntity(entity)
#		}
#)
#
#setMethod(
#		f = "Media",
#		signature = "numeric",
#		definition = function(entity){
#			Media(as.character(entity))
#		}
#)
#
#setMethod(
#		f = "Media",
#		signature = "list",
#		definition = function(entity){
#			ee <- new("Media")
#            ee@properties <- entity
#            ee@properties$entityType <- getSynapseTypeFromClass(as.character(class(ee)))
#            ee
#		}
#)
#
#setMethod(
#		f = "Media",
#		signature = "missing",
#		definition = function(entity){
#			Media(list())
#		}
#)
#
#setMethod(
#		f = "initialize",
#		signature = "Media",
#		definition = function(.Object, ...){
#			propertyValue(.Object, "type") <- "M"
#			.Object@location <- new("CachedLocation")
#			.Object
#		}
#)
#
#setMethod(
#		f = "show",
#		signature = "Media",
#		definition = function(object){
#			if(tolower(.Platform$GUI) == "rstudio")
#				lapply(object$files, function(f) file.show(file.path(object$cacheDir, f), title=f))
#			
#			cat('An object of class "', class(object), '"\n', sep="")
#			
#			cat("Synapse Entity Name : ", properties(object)$name, "\n", sep="")
#			cat("Synapse Entity Id   : ", properties(object)$id, "\n", sep="")
#			
#			if (!is.null(properties(object)$parentId))
#				cat("Parent Id           : ", properties(object)$parentId, "\n", sep="")
#			if (!is.null(properties(object)$type))
#				cat("Type                : ", properties(object)$type, "\n", sep="")
#			if (!is.null(properties(object)$versionNumber)) {
#				cat("Version Number      : ", properties(object)$versionNumber, "\n", sep="")
#				cat("Version Label       : ", properties(object)$versionLabel, "\n", sep="")
#			}
#			
#			files.msg <- summarizeCacheFiles(object@location)
#			if(!is.null(files.msg))
#				cat("\n", files.msg$count, "\n", sep="")
#			if(!is.null(propertyValue(object,"id"))){
#				cat("\nFor complete list of annotations, please use the annotations() function.\n")
#				cat(sprintf("To view this Entity on the Synapse website use the 'onWeb()' function\nor paste this url into your browser: %s\n", object@synapseWebUrl))
#			}
#		}
#		
#)
