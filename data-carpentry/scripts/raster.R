#load libraries

library(tidyverse)
library(terra)


# get info on raster file without loading it

describe("data/tud-dsm-5m.tif")


# load raster data

DSM_TUD <- rast("data/tud-dsm-5m.tif")

DSM_TUD


# retrieve general info on the raster
## it gives back values based on a random sample

summary(DSM_TUD)

## it gives back all the values of the raster

summary(values(DSM_TUD))


# transform the raster into df

DSM_TUD_df <- as.data.frame(DSM_TUD, xy = TRUE)

str(DSM_TUD_df)


# let's plot!
# we use the df object

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x=x, y=y, fill=`tud-dsm-5m`)) +
  scale_fill_viridis_c(option = "H") + #contrasting color scale
  coord_quickmap()

# let's look at the CRS

crs(DSM_TUD, proj = TRUE)


# calculate min and max values

minmax(DSM_TUD)

# store min and max in metadata

DSM_TUD <- setMinMax(DSM_TUD)


# run again minmax!

minmax(DSM_TUD)


# check the number of layers in a raster

nlyr(DSM_TUD)


# plot a histogram of raster values

ggplot() +
  geom_histogram(data = DSM_TUD_df, aes(`tud-dsm-5m`))


# plot raster data!

DSM_TUD_df <- DSM_TUD_df %>%
  mutate(fct_elevation = cut(`tud-dsm-5m`, breaks = 3))

ggplot()+
  geom_bar(data = DSM_TUD_df, aes(fct_elevation))

# examine the levels

levels(DSM_TUD_df$fct_elevation)


# customize the bins!

custom_bins <- c(-10, 0, 5, 100)


DSM_TUD_df <- DSM_TUD_df %>%
  mutate(fct_elevation_cb = cut(`tud-dsm-5m`, breaks = custom_bins))


levels(DSM_TUD_df$fct_elevation_cb)

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation_cb))


# plot raster

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x=x, y=y, fill=fct_elevation_cb)) +
  scale_fill_manual(values = terrain.colors(3), name = "Elevation") +
  coord_quickmap()


# Dealing with different CRS

DTM_TUD <- rast("data/tud-dtm-5m.tif")
DTM_hill_TUD <- rast("data/tud-dtm-5m-hill-WGS84.tif")

DTM_TUD_df <- as.data.frame(DTM_TUD, xy = TRUE)
DTM_hill_TUD_df <- as.data.frame(DTM_hill_TUD, xy = TRUE)

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  fill = `tud-dtm-5m`)) +
  geom_raster(data = DTM_hill_TUD_df,
              aes(x = x, y = y,
                  alpha = `tud-dtm-5m-hill`)) +
  scale_fill_gradientn(name = "Elevation",
                       colors = terrain.colors(10)) +
  coord_quickmap()

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  alpha = `tud-dtm-5m`)) +
  coord_quickmap()

ggplot() +
  geom_raster(data = DTM_hill_TUD_df,
              aes(x = x, y = y,
                  alpha = `tud-dtm-5m-hill`)) +
  coord_quickmap()

# reproject a raster

DTM_hill_EPSG28992_TUD <- project(DTM_hill_TUD,
                                  crs(DTM_TUD),
                                  res = res(DTM_TUD))

res(DTM_hill_EPSG28992_TUD)
res(DTM_TUD)

ext(DTM_hill_EPSG28992_TUD)
ext(DTM_TUD)

DTM_hill_EPSG28992_TUD_df <- as.data.frame(DTM_hill_EPSG28992_TUD,
                                           xy = TRUE)

ggplot() +
  geom_raster(data = DTM_TUD_df,
              aes(x = x, y = y,
                  fill = `tud-dtm-5m`)) +
  geom_raster(data = DTM_hill_EPSG28992_TUD_df,
              aes(x = x, y = y,
                  alpha = `tud-dtm-5m-hill`)) +
  scale_fill_gradientn(name = "Elevation",
                       colors = terrain.colors(10)) +
  coord_quickmap()

# Raster calculations

CHM_TUD <- DSM_TUD - DTM_TUD
CHM_TUD_df <- as.data.frame(CHM_TUD, xy = TRUE)

ggplot() +
  geom_raster(data = CHM_TUD_df,
              aes(x = x, y = y,
                  fill = `tud-dsm-5m`)) +
  scale_fill_gradientn(name = "Canopy Height",
                       colors = terrain.colors(10)) +
  coord_quickmap()

# Multi-band rasters

RGB_band1_TUD <- rast("data/tudlib-rgb.tif", lyrs = 1)

RGB_band1_TUD_df <- as.data.frame(RGB_band1_TUD, xy = TRUE)

ggplot() +
  geom_raster(data = RGB_band1_TUD_df,
              aes(x = x, y = y,
                  alpha = `tudlib-rgb_1`)) +
  coord_equal()
