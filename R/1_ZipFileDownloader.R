# Team: ZeaPol   
# Team Members: Roeland de Koning / Barbara Sienkiewicz    
# Date: 11/01/2015       
# Exercise 5

# Function to download and extract specified zip files to the data folder of R projects
# may need adjustment

ZipFileDownloader <- function(url, filedestination, filename) {
  
  deposit <- paste(filedestination, filename)
  file <- strsplit(filename, ".zip")
  filelocation <- paste("data/")
  download.file(url, deposit)
  
  # Extract files
  unzip(deposit, files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, 
        exdir = filelocation, unzip = "internal", setTimes = FALSE)

  # Find zip and remove it
  zip <- list.files("data/", pattern=glob2rx("*.zip"), full.names = TRUE)
  file.remove(zip)

}
