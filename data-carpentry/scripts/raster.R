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
  geom_raster(data = DSM_TUD_df, aes(x=x, y=y, fill=tud-dsm-5m )) +
  