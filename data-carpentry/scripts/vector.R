library(tidyverse)
library(sf)

boundary_Delft <- st_read("data/delft-boundary.shp", quiet = TRUE)

st_geometry_type(boundary_Delft)
st_crs(boundary_Delft)
st_bbox(boundary_Delft)


boundary_Delft <- st_transform(boundary_Delft, 28992)

st_crs(boundary_Delft)
st_crs(boundary_Delft)$Name
st_crs(boundary_Delft)$epsg

st_bbox(boundary_Delft)

st_crs(boundary_Delft)$units_gdal

boundary_Delft


ggplot(data = boundary_Delft) +
  geom_sf(size = 3, color = "black", fill = "cyan1") +
  labs(title = "Delft Administrative Boundary") +
  coord_sf()