# libreía leaflet
#llamar a la API, mapas interactivos 
library(leaflet)#
library(sf)
library(sp)
library(dplyr)
library(rgdal)


CCAA_MAP<-readOGR("C:/Users/Laura/Documents/Mineria_3/2.Espacial/Estadistica Espacial en R/cartografias","CCAA_SALARIOS")
summary(CCAA_MAP)

# tiene sus propias funciones:

leaflet(CCAA_MAP,options = leafletOptions(attributionControl = FALSE)) %>%
  addPolygons(data=CCAA_MAP, stroke=TRUE, opacity = 0.5, fillOpacity = 0.7,color="grey10",
              fillColor = ~colorQuantile("YlOrBr", n=9, SALARIO, na.color = "white")(SALARIO))


leaflet(CCAA_MAP,options = leafletOptions(attributionControl = FALSE)) %>%
  addTiles()%>%
  addPolygons(data=CCAA_MAP, stroke=TRUE, color="grey10")
  
leaflet(CCAA_MAP,options = leafletOptions(attributionControl = FALSE)) %>%
  addTiles()%>%
  addPolygons(data=CCAA_MAP, stroke=TRUE, opacity = 0.25, fillOpacity = 0.27,color="grey10",
              fillColor = ~colorQuantile("YlOrBr", n=9, SALARIO, na.color = "white")(SALARIO))


# pero no es necesario aprenderlas, ya que 
# la librería leaflet es utilizada tambien por tmap (que es de más fácil manejo)
library(tmaptools)
library(tmap)
# Para hacerlo Interactivo
tmap_mode("view")  # Esto pasa de ser un plot estático a uilizar leaflet y Viewer

tm_shape(CCAA_MAP) +
  tm_fill(palette ="Blues",col = "SALARIO",style = "quantile")


# para volver a hacer mapas con tmap en plot estático `tmap_mode("plot")`

# para añadir mapas base  + tm_basemap(server="OpenTopoMap"), o "OpenStreetMap" o "Esri.WorldGrayCanvas" o "Esri.WorldTopoMap"


# Para situar marcadores con leaflet
#PENDIENTE:PUNTO S DE UBICACI�N 
datos_map<-data.frame(longx=c(-3.741274,-3.718765,-3.707027,-3.737117, -3.674605,-3.709559 ),
                      laty=c(40.38479, 40.36751, 40.45495,40.44672, 40.50615, 40.42059))

awesome <- makeAwesomeIcon(
  icon = "circle",
  iconColor = "White",
  markerColor = "blue",
  library = "fa"
)

m <-leaflet(datos_map) %>%
  addTiles()%>%  
  addAwesomeMarkers(~longx,~laty,  popup = ~paste(laty, longx, sep = '<br/>'), icon = awesome)

m 


objetivo<-"Facultad de Estudios Estad�sticos, Madrid"
geo_output<-geocode_OSM(objetivo, details=TRUE, return.first.only = TRUE, as.data.frame = T )

laty=geo_output$lat
lonx=geo_output$lon

library(leaflet)

awesome <- makeAwesomeIcon(
  icon = "circle",
  iconColor = "White",
  markerColor = "blue",
  library = "fa"
)

leaflet(data.frame(lonx,laty)) %>% 
  addTiles() %>% 
  addAwesomeMarkers(lng=~lonx, lat=~laty,icon = awesome)










# Cargamos datos desde fichero 
Datos <- read.csv(file="C:/Users/Laura/Documents/Mineria_3/2.Espacial/Estadistica Espacial en R/datos_CCAA/Data_Housing_Madrid.csv",header=TRUE)

hist(Datos$house.price)


m1 <- leaflet(data=Datos[sample(nrow(Datos),100),]) %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addAwesomeMarkers(lng=~longitude,
             lat=~latitude,
             popup=~paste0(type.house, " - ", house.price, " euros"), icon = awesome)
m1  # Print the map



