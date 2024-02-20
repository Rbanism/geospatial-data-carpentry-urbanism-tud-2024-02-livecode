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

opq(bbox = bb) %>%
  add_osm_feature(key = "building") %>%
  osmdata_sf()

#if the error is "Overpass unavailable without internet"
assign("has_internet_via_proxy",TRUE,
       environment(curl::has_internet))
