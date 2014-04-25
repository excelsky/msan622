setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\5due0425v")
library(ggplot2)
library(reshape2)
library(scales)
library(shiny)


#### set a data structure ####
data(Seatbelts)
# ?Seatbelts
# head(Seatbelts)
# attributes(Seatbelts)
Seatbelts[, c("kms", "PetrolPrice", "law")]
sb_proto <- Seatbelts[,c("DriversKilled", "drivers", "front", 
  "rear", "kms", "PetrolPrice", "VanKilled", "law")]
rownames(sb_proto) <- 1:nrow(sb_proto)
sb_proto <- as.data.frame(sb_proto)

#### time extraction ####
# creates x-axis for time series
Zeit <- time(Seatbelts)

# note that 1/12 is approximately 0.0833
# note that february is 1974.083
print(Zeit)

# extract years for grouping later
Jahr <- floor(Zeit)
Jahr <- factor(Jahr, ordered=T)

# extract months by looking at time series cycle
cycle(Zeit)        # 1 through 12 for each year
print(month.abb)    # month abbreviations

# store month abbreviations as factor
Monat <- factor(
  month.abb[cycle(Zeit)],
  levels = month.abb,
  ordered = TRUE
)

# MOLTEN DATASET ######################
sb <- data.frame(
  year   = Jahr,
  month  = Monat,
  time   = as.numeric(Zeit),
  sb_proto
)
sb$law <- as.factor(sb$law)

schmelzen <- melt(
  sb,
  id = c("year", "month", "time")
)

#### data munging ####


# data(UKLungDeaths)
series <- as.numeric(time(ldeaths))
deaths <- as.numeric(ldeaths) 
male   <- as.numeric(mdeaths) 
female <- as.numeric(fdeaths)

lungdata <- data.frame(series, deaths, male, female)
lungmelt <- melt(lungdata, id = "series")

grey <- "#dddddd"

plotOverview <- function(start = 1969, num = 12) {
  xmin <- start
  xmax <- start + (num / 12)
  
  ymin <- 1200
  ymax <- 4000
  
  p <- ggplot(sb, aes(x = time, y = DriversKilled))
  
  p <- p + geom_rect(
    xmin = xmin, xmax = xmax,
    ymin = ymin, ymax = ymax,
    fill = grey)
  
  p <- p + geom_line()
  
  p <- p + scale_x_continuous(
    limits = range(sb$time),
    expand = c(0, 0),
    breaks = seq(start, 1985, by = 1))
  
  p <- p + scale_y_continuous(
    limits = c(ymin, ymax),
    expand = c(0, 0),
    breaks = seq(ymin, ymax, length.out = 3))
  
  p <- p + theme(panel.border = element_rect(
    fill = NA, colour = grey))
  
  p <- p + theme(axis.title = element_blank())
  p <- p + theme(panel.grid = element_blank())
  p <- p + theme(panel.background = element_blank())
  
  return(p)
}

plotArea <- function(start = 1969, num = 12) {
  xmin <- start
  xmax <- start + (num / 12)
  
  ymin <- 0
  ymax <- 4000
  
  p <- ggplot(
    subset(schmelzen, variable!="drivers" & variable!="kms" &
           variable!="PetrolPrice" & variable!="law"),
    aes(x = time, y = value, 
        group = variable,
        fill = variable))
  
  p <- p + geom_area()
  
  minor_breaks <- seq(
    floor(xmin), 
    ceiling(xmax), 
    by = 1/ 12)
  
  p <- p + scale_x_continuous(
    limits = c(xmin, xmax),
    expand = c(0, 0),
    oob = rescale_none,
    breaks = seq(floor(xmin), ceiling(xmax), by = 1),
    minor_breaks = minor_breaks)
  
#   p <- p + scale_y_continuous(
#     limits = c(ymin, ymax),
#     expand = c(0, 0),
#     breaks = seq(ymin, ymax, length.out = 5))
  
  p <- p + theme(axis.title = element_blank())
  
  p <- p + theme(
    legend.text = element_text(
      colour = "white",
      face = "bold"),
    legend.title = element_blank(),
    legend.background = element_blank(),
    legend.direction = "horizontal", 
    legend.position = c(0, 0),
    legend.justification = c(0, 0),
    legend.key = element_rect(
      fill = NA,
      colour = "white",
      size = 1))
  
  return(p)
}

# test_start = 1979.35
# print(plotOverview(start = test_start))
# print(plotArea(start = test_start))