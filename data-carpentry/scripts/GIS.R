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

str(buildings_polygons)

buildings_polygons$start_date <- as.numeric(
  buildings_polygons$start_date)
buildings_polygons$new_date <- if_else(
  buildings_polygons$start_date < 1900, 
  1900, #if true
  buildings_polygons$start_date #if false
  )

ggplot(data = buildings_polygons) +
  geom_sf(aes(fill = new_date,
              colour = new_date)) +
  scale_fill_viridis_c(option ="viridis") +
  scale_colour_viridis_c(option ="viridis")


buildings_polygons <- buildings_polygons %>%
  st_transform(.,crs = "4326")






