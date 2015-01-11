# Team: ZeaPol   
# Team Members: Roeland de Koning / Barbara Sienkiewicz    
# Date: 11/01/2015       
# Exercise 5

# Function to read .shp file


readSHP <- function(FolderLocation, Pattern) {
  
  listSHP <- list.files(FolderLocation, pattern = glob2rx(Pattern), full.names = TRUE)
  
  readSHP <- readOGR(listSHP, layer=ogrListLayers(listSHP))
    
}