# Team: ZeaPol   
# Team Members: Roeland de Koning / Barbara Sienkiewicz    
# Date: 11/01/2015       
# Exercise 5


# Script made as a part of "Introduction to the vector handling in R" lesson.
# All steps are discribed in comments.


# Load libraries:
library(raster)
library(sp)
library(rgdal)
library(rgeos)
library(maptools)

# Sources of functions:
source('R/1_ZipFileDownloader.R')
source('R/2_ReadOGR.R')

# Download and unzip files into "data" folder and remove zip file:
ZipFileDownloader("http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip",
                  "data/","netherlands-places-shape.zip")
ZipFileDownloader("http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip",
                  "data/","netherlands-railways-shape.zip")

# Read required .shp files:
railways <- readSHP("data/", "*railways.shp")
places <- readSHP("data/", "*places.shp")

# Plot these files:
plot(places)
plot(railways)

# Plot rail tracks with type "industrial":
IndustrialRail <- railwaysshp[railwaysshp$type == "industrial",]
plot(IndustrialRail)

# Industrial rail reprojected into RD:
PrjStringRD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
IndustrialRailRD <- spTransform(IndustrialRail, PrjStringRD)
PlacesRD <- spTransform(places, PrjStringRD)

# Buffer the “industrial” railways with a buffer of 1000m:
BufferIndustrial <- gBuffer(IndustrialRailRD, byid=TRUE, width=1000)
plot(BufferIndustrial)

# Find the place (i.e. a city) that intersects with this buffer
IntersectingPlaces <- gIntersection(BufferIndustrial, placesRD)

# The information about place's name and polulation:
locationinfo <- gIntersects(BufferIndustrial, placesRD, byid=TRUE)
placesRD@data[locationinfo]

# Create a plot that shows the buffer, the points, and the name of the city
# and saving in as png into output polder
png(filename="output/plot.png")
buffer <- plot(BufferIndustrial, main = "Utrecht", bg = "darkolivegreen4")
places <- plot(IntersectingPlaces, add = TRUE, pch=21, col="grey0", bg="lightblue3", cex = 5)
grid()
box()
dev.off()

# The name of the intersecting city: Utrecht
# Population of the intersecting city: 100,000