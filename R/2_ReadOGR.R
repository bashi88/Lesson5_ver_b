# Team: ZeaPol   
# Team Members: Roeland de Koning / Barbara Sienkiewicz    
# Date: 11/01/2015       
# Exercise 5

# 


readSHP <- function(FolderLocation, Pattern) {
  
  listSHP <- list.files(FolderLocation, pattern = glob2rx(Pattern), full.names = TRUE)
  
  readSHP <- readOGR(listSHP, layer=ogrListLayers(listSHP))
    
}

readSHP ("data/", "*railways.shp")