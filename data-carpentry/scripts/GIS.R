#install.packages("nominatimlite")
library(nominatimlite)
library(tidyverse)
library(sf)


nominatim_polygon <- geo_lite_sf("Brielle",
                                 points_only = FALSE) 

bb <- st_bbox(nominatim_polygon)
bb

#install.packages("osmdata")
library(osmdata)

buildings <- opq(bbox = bb) %>%
  add_osm_feature(key = "building") %>%
  osmdata_sf()

str(buildings)

buildings_polygons <- buildings$osm_polygons %>%
  st_transform(.,crs=28992)

ggplot(data = buildings_polygons) +
  geom_sf()



