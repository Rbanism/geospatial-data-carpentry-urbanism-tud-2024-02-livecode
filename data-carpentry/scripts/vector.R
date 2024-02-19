library(tidyverse)
library(sf)

boundary_Delft <- st_read("data/delft-boundary.shp", quiet = TRUE)

st_geometry_type(boundary_Delft)
