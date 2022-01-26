library(readxl)
library(ggplot2)
theme_set(theme_bw())
library(sf)
library(rnaturalearth)  
library(rnaturalearthdata)
library(elevatr)
library(viridis)
library(geometry)

reflex_data <- read.csv("~/projects/acd-fork/etc/exports/reflexes-with-gcp.csv")
bulbul <- reflex_data[reflex_data$ProtoForm == "*bulbúl",]

# Isoglosses
build_subgroup_isogloss <- function(df, subgroup) {
  unique_points <- df[!duplicated(df[,c("Latitude", "Longitude")]),]
  while (nrow(unique_points) < 3) {
    

# Mapping

world <- ne_countries(scale = "large", returnclass = "sf")
class(world)
ph_limits <- data.frame(x = c(117, 128),y = c(21, 0.1)) # Latitude and longitude 
  
elev <- elevatr::get_elev_raster(locations = ph_limits, prj = "EPSG:4326", z = 5, clip = "locations")
elevation_data <- raster::as.data.frame(elev, xy = TRUE)
colnames(elevation_data)[3] <- "elevation"
elevation_data <- elevation_data[complete.cases(elevation_data),] # Remove NAs
elevation_data <- elevation_data[elevation_data$elevation > 0,] # Remove bathymetry

ggplot(data = world) +
  geom_tile(data = elevation_data, aes(x = x, y = y, fill = elevation)) +
  geom_sf(fill="transparent") +
  scale_fill_viridis(direction = 1, option = "viridis") +
  coord_sf(xlim = ph_limits$x, ylim = ph_limits$y, expand=FALSE) +
  geom_point(data = reflex_data, aes(x = Longitude, y = Latitude), size = 3, shape = 23, fill = "white") +
  geom_point(data = bulbul, aes(x = Longitude, y = Latitude), size = 4, shape = 23, fill = "red")


