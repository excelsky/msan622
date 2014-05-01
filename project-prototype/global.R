# setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\final")
library(e1071)
library(ggplot2)
library(plyr)
library(reshape2)
library(scales)
library(shiny)

data1 <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", sep=",", header=F, na.strings=" ?")
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
               mean_capital_gain = round(mean(capital_gain), 2),
               mean_capital_loss = round(mean(capital_loss), 2),
               mean_education_num = round(mean(education_num), 2),
               mean_hours_per_week = round(mean(hours_per_week), 2))
data2$continents <- c("Asia", "North_America", "Asia", "South_America",
                      "North_America", "North_America",
                      "South_America", "North_America", "Europe", "Europe",
                      "Europe", "Europe", "North_America", "North_America",
                      "Europe", "North_America", "Asia", "Europe",
                      "Asia", "Asia", "Asia", "Europe",
                      "North_America", "Asia", "Asia", "North_America",
                      "North_America", "Australia", "South_America", "Asia",
                      "Europe", "Europe", "North_America", "Europe",
                      "Asia", "Asia", "Asia", "South_America",
                      "North_America", "Asia", "Europe")


#### Create bubble plot ####
bubblebubble <- function(x, y, sizeBy, colorBy, abbrev) {
#   bubblebubble("mean_age", "mean_hours_per_week", "mean_fnlwgt", "continents", T)
  df <- data2
  sizeIndex <- which(colnames(df) == sizeBy)
  
  # Sort in order to have smaller colors displayed on top of the bigger colors
  df <- df[order(df[,sizeIndex], decreasing = TRUE),]
  
  # Create actual bubble plot
  p <- ggplot(df, aes_string(x = x, y = y)) +
    geom_point(aes_string(size = sizeBy, color = colorBy), alpha = 0.8)
  
  
  # Option of having a country name
  if(abbrev){
    p <- p + geom_text(aes(label = native_country), col="#000000", hjust=0.5, vjust=0)  
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



densitydensity <- function(x) {
# densitydensity("age")
  df <- data1
#   over50k <- subset(data1, income==" >50K")
#   less50k <- subset(data1, income==" <=50K")
  
  # Create actual density plot
  p <- ggplot(data1, aes(x = age ,
        group = income, color = income, fill = income))  
  p <- p + geom_density(alpha=0.8)
  
  # Legend
  p <- p + scale_fill_discrete(breaks=c("trt1","ctrl"))
  
  p <- p + scale_size_area(max_size = 20, guide = "none")
  return(p)
}
