library(ggplot2)
theme_set(theme_bw())
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(elevatr)
library(viridis)
library(geometry)
library(DescTools)
library(dplyr)
library(testit)

#### Data

## List of Philippine microgroups, from Blust 1991. I substitute, based on Glottolog:
## - 'Batanic' for Bashiic
## - 'Northern Luzon' for Cordilleran
## - 'Ati' for Inati
## - 'Subanen' for Subanon
microgroups <- c(
  "Batanic",
  "Northern Luzon",
  "Central Luzon",
  "Ati",
  "Kalamian",
  "Bilic",
  "South Mangyan",
  "Palawanic",
  "Central Philippine",
  "Manobo",
  "Danaw",
  "Subanen",
  "Sangiric",
  "Minahasan",
  "Gorontalo-Mongondow"
)
assert(length(microgroups) == 15)

## PPh lexical innovations from the ACD, Blust's reconstructions with reflexes. Add a
## Microgroup column so we can plot Blust 1991's microgroups
match <- sapply("(?<!Greater )", paste, microgroups, sep = "") # Distinguish CP from GCP
reflex_data <- read.csv("~/projects/acd-fork/etc/exports/reflexes-with-gcp.csv") |>
  rowwise() |>
  mutate(Microgroup = as.integer(list(which(sapply(match, grepl, Subgroup, perl = TRUE)))))
             
## Some sample subsets filtered on different column values:
bulbul <- reflex_data[reflex_data$ProtoForm == "*bulbúl",]
batanic <- reflex_data[grep("Batanic", reflex_data$Subgroup),]
nluzon <- reflex_data[grep("Northern Luzon", reflex_data$Subgroup),]
abaka <- reflex_data[reflex_data$ProtoForm == "*abaká",]

#### Helper functions

build.isogloss <- function(df) {
  #' Compute the convex hull of the set of language locations in
  #' the input dataframe. Hacky? I don't know R
  unique.points <- df[!duplicated(df[,c("Latitude", "Longitude")]),]
  xrange <- range(na.omit(df$Longitude))
  yrange <- range(na.omit(df$Latitude))
  xys <- na.omit(unique.points[c("Longitude", "Latitude")])
  while (nrow(xys) < 3) { # Need at least 3 points for a cnvhull, so add random points at a sensible distance
    xys <- rbind(xys, data.frame(Longitude=runif(1, xrange[1], xrange[2]), Latitude=runif(1, yrange[1], yrange[2])))
  }
  ## Convhulln returns hull vertices represented as pairs of row indices for input frame
  hull <- convhulln(xys)
  segments <- as.data.frame(matrix(0, ncol = 4, nrow = nrow(hull)))
  colnames(segments) <- c("startx", "starty", "endx", "endy")
  for (i in 1:nrow(hull)) {
    start <- hull[i,][1]
    end <- hull[i,][2]
    line <- list(xys[start,]$Longitude, xys[start,]$Latitude, xys[end,]$Longitude, xys[end,]$Latitude)
    segments[i,] <- line
  }
  return(segments)
}

#### Mapping setup

world <- ne_countries(scale = "large", returnclass = "sf")
class(world)
ph.limits <- data.frame(x = c(117, 128),y = c(22, 0.1)) # Latitude and longitude of Philippines + N. Sulawesi and the Batanes
elev <- elevatr::get_elev_raster(locations = ph.limits, prj = "EPSG:4326", z = 7, clip = "locations")
elevation_data <- raster::as.data.frame(elev, xy = TRUE)
colnames(elevation_data)[3] <- "elevation"
elevation_data <- elevation_data[complete.cases(elevation_data),] # Remove NAs
elevation_data <- elevation_data[elevation_data$elevation > 0,] # Remove bathymetry

#### Maps, wrapped in functions so they don't all try to draw at once when script run

example.map <- function() {
  ggplot(data = world) +
    geom_tile(data = elevation_data, aes(x = x, y = y, fill = elevation)) +
    geom_sf(fill="transparent") + # Borders, not necessary with elevation
    scale_fill_viridis(direction = 1, option = "viridis") +
    coord_sf(xlim = ph.limits$x, ylim = ph.limits$y, expand=FALSE) +
    geom_point(data = reflex_data, aes(x = Longitude, y = Latitude), size = 3, shape = 23, fill = "white") + # All langs
    geom_curve(data = build.isogloss(batanic), aes(x = startx, y = starty, xend = endx, yend = endy), color = "red") +
    geom_point(data = bulbul, aes(x = Longitude, y = Latitude), size = 4, shape = 23, fill = "red")
}

microgroups.map <- function() {
  all.langs <- reflex_data |> distinct(ACDName, .keep_all = TRUE)
  ggplot(data = world) +
    geom_tile(data = elevation_data, aes(x = x, y = y, fill = elevation)) +
    scale_fill_viridis(direction = 1, option = "cividis") +
    coord_sf(xlim = ph.limits$x, ylim = ph.limits$y, expand=FALSE) +
    geom_point(data = reflex_data, aes(x = Longitude, y = Latitude, color = factor(Microgroup)), size = 3, shape = 1)
}
