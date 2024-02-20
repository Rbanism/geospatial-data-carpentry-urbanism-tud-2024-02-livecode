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


