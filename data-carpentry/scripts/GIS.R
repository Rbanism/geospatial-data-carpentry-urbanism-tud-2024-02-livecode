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
  st_transform(.,crs = 4326)

library(leaflet)

leaflet(buildings_polygons) %>%
  addProviderTiles(
    providers$CartoDB.Positron) %>%
  addPolygons(color="#444444",weight=0.1,
    fillColor = ~colorQuantile("YlGnBu",
                               -new_date)(
                                 -new_date)
  )



#### Part 2 - GIS functions

old_buildings_polygons <- buildings_polygons %>%
  mutate(isOld = if_else(start_date <= 1800,
                        1,0)) %>%
  filter(isOld == 1)

ggplot(data = old_buildings_polygons) +
  geom_sf(colour = "red")

old_buildings_polygons <- old_buildings_polygons %>%
  st_transform(.,crs=28992)


# Buffer
buffer <- st_buffer(x = old_buildings_polygons,
                    dist = 100)

ggplot(data = buffer) +
  geom_sf()


# Union
united_buffer <- st_union(buffer) %>%
  st_cast(to = "POLYGON") %>%
  st_as_sf()

ggplot(data = united_buffer) +
  geom_sf()

str(united_buffer)

united_buffer <- united_buffer %>%
  mutate("ID" = as.factor(1:nrow(united_buffer))) %>%
  st_transform(., crs=28992)

# centroids

buildings_centroids <- st_centroid(old_buildings_polygons) %>%
  st_transform(., crs=28992)

st_crs(buildings_centroids)



ggplot(data = buildings_centroids) +
  geom_sf()
