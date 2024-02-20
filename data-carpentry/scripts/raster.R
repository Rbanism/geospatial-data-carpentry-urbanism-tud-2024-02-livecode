#load libraries

library(tidyverse)
library(terra)


# get info on raster file without loading it

describe("data/tud-dsm-5m.tif")


# load raster data

DSM_TUD <- rast("data/tud-dsm-5m.tif")

DSM_TUD


# retrieve general info on the raster

summary(DSM_TUD)
