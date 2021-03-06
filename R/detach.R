## Detach a LocationOwner entity from the search path
## 
## Author: Matthew D. Furia <matt.furia@sagebase.org>
###############################################################################

setMethod(
  f = "detach",
  signature = "SynapseLocationOwner",
  definition = function (name, pos = 2, unload = FALSE, character.only = FALSE, 
    force = FALSE) {
    pkgName <- getPackageName(name)
    detach(name=pkgName, pos = pos, unload = unload, character.only = TRUE) 
  }
)

