setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\final")
library(ggplot2)
library(plyr)
library(reshape2)
library(scales)
library(shiny)

data1 <- read.table("adult.data", sep=",", header=F, na.strings=" ?")
data1 <- na.omit(data1)
table(data1[,length(data1)])
colnames(data1) <- c("age", "workclass", "fnlwgt", "education", "education_num",
                     "marital_status", "occupation", "relationship", "race", "sex",
                     "capital_gain", "capital_loss", "hours_per_week", "native_country", "income")
num_df <- data1[,c(1,3,5,11,12,13)]
char_df <- data1[,c(2,4,6,7,8,9,10,14,15)]
head(num_df)
head(char_df)
unique(data1$native_country)
unique(data1$occupation)
str(num_df)
str(char_df)
data2 <- ddply(data1, .(native_country), summarize,
               mean_age = round(mean(age), 2),
               mean_fnlwgt = round(mean(fnlwgt), 2),
               mean_education_num = round(mean(education_num), 2),
               mean_hours_per_week = round(mean(hours_per_week), 2))

#### Create bubble plot ####
bubble <- function(x, y, sizeBy, colorBy, abbrev) {
  df <- data1
  sizeIndex <- which(colnames(df) == sizeBy)
  
  # Sort in order to have smaller colors displayed on top of the bigger colors
  df <- df[order(df[,sizeIndex], decreasing = TRUE),]
  
  # Create actual bubble plot
  p <- ggplot(df, aes_string(x = x, y = y)) +
    geom_point(aes_string(size = sizeBy, color = colorBy), alpha = 0.8)
  
  
  # Option of having a state abbreviation
  if(abbrev){
    p <- p + geom_text(aes(label = Abbrev), col="#000000", hjust=0.5, vjust=0)  
  }
  
  # Default size scale is by radius, force to scale by area instead
  p <- p + scale_size_area(max_size = 20, guide = "none")
  
  # Modify the legend settings
  p <- p + theme(legend.title = element_blank())
  p <- p + theme(legend.direction = "horizontal")
  p <- p + theme(legend.position = c(1, 0))
  p <- p + theme(legend.justification = c(1, 0))
  p <- p + theme(legend.background = element_blank())
  p <- p + theme(legend.key = element_blank())
  p <- p + theme(legend.text = element_text(size = 12))
  #   p <- p + theme(legend.margin = unit(0, "pt"))
  
  # Force the dots to plot larger in legend
  p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
  
  return(p)
}
