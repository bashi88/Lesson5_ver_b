# Team: ZeaPol   
# Team Members: Roeland de Koning / Barbara Sienkiewicz    
# Date: 11/01/2015       
# Exercise 5

# Function to download and extract specified zip files to the data folder of R projects


ZipFileDownloader <- function(url, filedestination, filename) {
  
  deposit <- paste(filedestination, filename) # Gives the directory of the zip file
  file <- strsplit(filename, ".zip") # Gives the name of the file (without extension)
  filelocation <- paste("data/", file)
  download.file(url, deposit)
  
  # Extract files:
  unzip(deposit, files = NULL, list = FALSE, overwrite = TRUE, junkpaths = FALSE, 
        exdir = "data", unzip = "internal", setTimes = FALSE)

  # Find zip and remove it:
  zip <- list.files("data/", pattern=glob2rx("*.zip"), full.names = TRUE)
  file.remove(zip)

}