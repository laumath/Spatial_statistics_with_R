# Búsquda de coordendas
# con OpenStreetMaps 

#(google MAps tiene una API en la que hy que registrarse qe también permite búsqueda de rutas)
# también API cartoDB (library cartodb-r API: http://developers.cartodb.com/)
# tambien API HERE (library(hereR)  https://developer.here.com/sign-up?create=Freemium-Basic&keepState=true&step=account)
# también ESRI (arcGis library(leaflet.esri)


library(tmaptools) ## es esta la que se necesita

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


#Al revés si tengo una localización laty=40.4, lonx=-3.74, puedo encontrar la dirección

rev_geocode_OSM(x=lonx, y=laty)


# El paquete OSRM rCarto permite utilizar rutas óptimas utilizando OpenStreetMap

library(osrm)

destino<-"Facultad Comercio y Turismo, Madrid"
geo_output<-geocode_OSM(destino, details=TRUE, return.first.only = TRUE, as.data.frame = T )


laty_destino=geo_output$lat
lonx_destino=geo_output$lon

ruta<-osrmRoute(src= c(lonx,laty), dst = c(lonx_destino, laty_destino), returnclass = "sp" , overview =  "full")

#proporciona el tiempo en minutos y la distancia en kilómetros
ruta@data


# Ahora podemos añadirlo al leafleat
leaflet(ruta) %>% 
  addTiles() %>%
  addAwesomeMarkers(lng=~lonx, lat=~laty,icon = awesome) %>%
  addAwesomeMarkers(lng=~lonx_destino, lat=~laty_destino,icon = awesome)%>%
  addPolylines(color="blue",label = (paste0(ruta@data$duration, " minutos, ", ruta@data$distance, " kms")))

