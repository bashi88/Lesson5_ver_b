# Team: ZeaPol   
# Team Members: Roeland de Koning / Barbara Sienkiewicz    
# Date: 08/01/2015       
# Exercise 5

railway2 = readOGR("data/","railways.shp")


data.shape<-readOGR(dsn="data/",layer="Railways")
plot(data.shape)

places <- readShapePoints("data/places.shp")
railways <- readShapeSpatial("data/railways.shp")
plot(places)
plot(railways)
industrialrail<- railways[railways$type == "industrial",]
plot(industrialrail)

bufferindustrial <- gBuffer(industrialrail, byid=FALSE, width=1000, joinStyle = 'MITRE', quadsegs=4)
plot(bufferindustrial)

prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")

industrialrailRD <- spTransform(industrialrail, prj_string_RD)
