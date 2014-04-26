# setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\5due0425v")
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
# sb_proto <- Seatbelts[,c("DriversKilled", "drivers", "front", 
#   "rear", "kms", "PetrolPrice", "VanKilled", "law")]
sb_proto <- Seatbelts[,c("DriversKilled", "front", "rear")]
rownames(sb_proto) <- 1:nrow(sb_proto)
sb_proto <- as.data.frame(sb_proto)

#### time extraction ####
# creates x-axis for time series
Zeit <- time(Seatbelts)

# note that 1/12 is approximately 0.0833
# note that february is 1974.083
# print(Zeit)

# extract years for grouping later
Jahr <- floor(Zeit)
Jahr <- factor(Jahr, ordered=T)

# extract months by looking at time series cycle
# cycle(Zeit)        # 1 through 12 for each year

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


# schmelzen <- melt(
#   sb,
#   id = c("year", "month", "time")
# )
# schmelzen$value <- as.numeric(schmelzen$value)

grey <- "#dddddd"

plotArea <- function(start=1969, num=12, SAPvar) {
  #   plotArea(start, num, "front")
  #   plotArea(start, num, c("front", "rear"))
  #   plotArea(start, num, c("front", "rear", "DriversKilled"))
  xmin <- start
  xmax <- start + (num / 12)
  
  # Get indices in columns and variables
  idx <- 1:ncol(sb)
  variableIndex <- idx[colnames(sb) %in% SAPvar]
  
  
  if (length(variableIndex) < 1) {
    sb <- data.frame(ex=0, wy=0,
                     labels = "Please, choose at least one variable.\n
                     A line plot needs your support.\n
                     Please, donate your click.\n")
    p <- ggplot(sb) +
      geom_text(aes(x=ex, y=wy, label = labels), size=15) +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank())
  }
  
  else{
    
    ymin <- min(floor(sb[,variableIndex]))
    ymax <- max(ceiling(sb[variableIndex]))
    
    sb1 <- cbind(sb$time, sb[,variableIndex])
    sb1 <- as.data.frame(sb1)
    colnames(sb1)[1] <- "time"
    
    if(ncol(sb1)==2) {colnames(sb1)[2] <- SAPvar}
    
    
    schmelzen <- melt(
      sb1,
      id = c("time")
    )
    schmelzen$value <- as.numeric(schmelzen$value)
    
    p <- ggplot(
      schmelzen,
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
      breaks = seq(floor(xmin), ceiling(xmax), by = 1/4),
      minor_breaks = minor_breaks)
    
#     p <- p + scale_y_continuous(
#       limits = c(ymin, ymax),
#       expand = c(0, 0),
#       breaks = seq(ymin, ymax, length.out = 5))
    
#     p <- p + theme(axis.title = element_blank())
    
    p <- p + theme(
      legend.text = element_text(
        colour = "black",
        face = "bold"),
      legend.title = element_blank(),
      legend.background = element_blank(),
      legend.direction = "horizontal", 
      legend.position = c(1, 1),
      legend.justification = c(1, 1),
#       legend.key = element_rect(
#         fill = NA,
#         colour = "white",
#         size = 1)    
      legend.key = element_blank(),
      legend.text = element_text(size=12, face="italic"),
      text = element_text(size=14, face="italic"),
      panel.border = element_blank(),
      panel.background = element_rect(fill = NA),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey80", linetype = 3),
      axis.ticks.x = element_blank()
    )
    
    p <- p + xlab("Time")
    p <- p + ylab("Death")
    p <- p + scale_colour_discrete(limits = SAPvar)
  }
  return(p)
}

plotOverview <- function(start=1969, num=12, LPvar) {
  #   plotOverview(start, num, "front")
  xmin <- start
  xmax <- start + (num / 12)
  
  ymin <- min(floor(sb[,colnames(sb) == LPvar]))
  ymax <- max(ceiling(sb[,colnames(sb) == LPvar]))
  
  
  p <- ggplot(sb, aes_string(x="time", y=as.character(LPvar)))
  
  p <- p + geom_rect(
    xmin = xmin, xmax = xmax,
    ymin = ymin, ymax = ymax,
    fill = grey)
  
  p <- p + geom_line(size=1.15)
  
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

# test_start = 1979.35
# print(plotOverview(start = test_start))
# print(plotArea(start = test_start))
