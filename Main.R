# Team: ZeaPol   
# Team Members: Roeland de Koning / Barbara Sienkiewicz    
# Date: 08/01/2015       
# Exercise 5

<<<<<<< HEAD
library(raster)
library(sp)
library(rgdal)
library(rgeos)
library(maptools)

source('R/ZipfileDownloader.R')

ZipfileDownloader("http://www.mapcruzin.com/download-shapefile/netherlands-places-shape.zip","data/","netherlands-places-shape.zip")
ZipfileDownloader("http://www.mapcruzin.com/download-shapefile/netherlands-railways-shape.zip","data/","netherlands-railways-shape.zip")

railways<-list.files("data/", pattern = glob2rx("*railways.shp"),full.names = TRUE)
places<-list.files("data/",pattern = glob2rx("*places.shp"),full.names = TRUE)

railwaysshp<-readOGR(railways, layer=ogrListLayers(railways))
placesshp<-readOGR(places, layer=ogrListLayers(places))

plot(places)
plot(railways)

industrialrail<- railwaysshp[railwaysshp$type == "industrial",]
plot(industrialrail)

prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")
industrialrailRD <- spTransform(industrialrail, prj_string_RD)
placesRD <- spTransform(placesshp, prj_string_RD)

bufferindustrial <- gBuffer(industrialrailRD, byid=TRUE, width=1000)
plot(bufferindustrial)
intersectingplaces<- gIntersection(bufferindustrial,placesRD)

plot(bufferindustrial,main = "Utrecht")
plot(intersectingplaces,add=TRUE)

#very basic plot there is a better way

locationinfo<- gIntersects(bufferindustrial,placesRD,byid=TRUE)
placesRD@data[locationinfo]



# name of intersecting city: Utrecht
# population of intersecting city: 100,000


# Selects the “industrial” (type == "industrial") railways
# Buffers the “industrial” railways with a buffer of 1000m (hint: gBuffer with byid=TRUE)
# Find the place (i.e. a city) that intersects with this buffer.
# Create a plot that shows the buffer, the points, and the name of the city
# write down the name of the city and the population of that city as one comment at the end of the script.
# Bonus (optional!): if you can also download and unzip this within the script.

