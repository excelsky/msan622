# setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\final")
library(ggplot2)
library(plyr)
library(RColorBrewer)
library(reshape2)
library(scales)
library(shiny)


# data1 <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", sep=",", header=F, na.strings=" ?")
data1 <- read.csv("data1.csv", header=T)
data2 <- read.csv("data2.csv", header=T)
data3 <- read.csv("data3.csv", header=T)
melt4e <- read.csv("melt4e.csv", header=T)
melt4o <- read.csv("melt4o.csv", header=T)
melt4w <- read.csv("melt4w.csv", header=T)


data3$workclass <- factor(data3$workclass, levels=names(sort(table(data3$workclass), dec=T)))
data3$education <- factor(data3$education, levels=names(sort(table(data3$education), dec=T)))
data3$marital_status <- factor(data3$marital_status, levels=names(sort(table(data3$marital_status), dec=T)))
data3$occupation <- factor(data3$occupation, levels=names(sort(table(data3$occupation), dec=T)))
data3$relationship <- factor(data3$relationship, levels=names(sort(table(data3$relationship), dec=T)))
data3$race <- factor(data3$race, levels=names(sort(table(data3$race), dec=T)))
data3$sex <- factor(data3$sex, levels=names(sort(table(data3$sex), dec=T)))

melt4e$variable <- factor(melt4e$variable, levels=levels(melt4e$variable)[c(14,4,5,6,7,1,2,3,12,9,8,16,10,13,15,11)])
levels(melt4e$native_country) <- sort(levels(melt4e$native_country), dec=T)
levels(melt4o$native_country) <- sort(levels(melt4o$native_country), dec=T)
levels(melt4w$native_country) <- sort(levels(melt4w$native_country), dec=T)

num_df <- data1[,c(1,4,10,11,12)]
char_df <- data1[,c(2,3,5,6,7,8,9,13,14)]


#### colnames vs variable names in data1 ####
colnames1 <- colnames(data1)
varnames1 <- c("Age", "Work Class", "Highest Degree in Education",      
                "Years of Education",  "Marital Status", "Occupation", "Relationship",
                "Race", "Sex", "Capital Gain", "Capital Loss",
                "Work Hours per Week", "Native Country", "Income")


#### colnames vs variable names in data2 ####
colnames2 <- colnames(data2)
varnames2 <- c("native_country", "Mean Age",
              "Mean Education Years", "Mean Capital Gain", "Mean Capital Loss",
              "Mean Hours per Week", "continents")




#### Create bubble plot ####
bubblebubble <- function(x1, y1, sizeBy, abbrev, aCoun, eCoun, naCoun, saCoun) {
#   bubblebubble("Mean Education Years", "Mean Hours per Week", "Mean Age", T, "all", "all", "all", "all")
  df <- data2
  x <- colnames2[which(varnames2 == x1)]
  y <- colnames2[which(varnames2 == y1)]
  sizeBy <- colnames2[which(varnames2 == sizeBy)]
  xIndex <- which(colnames2 == x)
  yIndex <- which(colnames2 == y)
  sizeIndex <- which(colnames2 == sizeBy)
  
  if ((aCoun == "All") && (length(aCoun)>0)) {
    aCoun <- c("Cambodia", "China", 
               "Hong Kong", "India", "Iran", "Japan",            
               "Laos", "Philippines", "South Korea", "Taiwan",
               "Thailand", "Vietnam")
  }
  
  if ((eCoun == "All") && (length(eCoun)>0)) {
    eCoun <- c("England", "France", "Germany", "Greece",
               "Netherlands", "Hungary", "Ireland", "Italy", 
               "Poland", "Portugal", "Scotland", "Yugoslavia")
  }
  
  if ((naCoun == "All") && (length(naCoun)>0)) {
    naCoun <- c("Canada", "Cuba", "Dominican Republic", "El Salvador",
                "Guatemala", "Haiti", "Honduras", "Jamaica",
                "Mexico", "Nicaragua", "Puerto Rico", "United States")
  }
  
  if ((saCoun == "All") && (length(saCoun)>0)) {
    saCoun <- c("Columbia", "Ecuador", "Peru", "Trinadad&Tobago")
  }
  
  allCoun <- c(aCoun, eCoun, naCoun, saCoun)
  xadj <- (floor(min(df[,xIndex])) + ceiling(max(df[,xIndex]))) / 25
  yadj <- (floor(min(df[,yIndex])) + ceiling(max(df[,yIndex]))) / 25
  xmin <- floor(min(df[,xIndex])) - xadj
  xmax <- ceiling(max(df[,xIndex])) + xadj
  ymin <- floor(min(df[,yIndex])) - yadj
  ymax <- ceiling(max(df[,yIndex])) + yadj
  
  
  if (length(allCoun) == 0) {
    p <- ggplot(df, aes_string(x = x, y = y)) +
      xlab(varnames2[which(colnames2 == x)]) + ylab(varnames2[which(colnames2 == y)]) +
      annotate("text", x=1 , y=5, label="Oops!\n
               You have reached a not very scary Blue Screen of Death.\n
               Please select at least one country.\n
               Thank you for your cooperation.",
               colour='blue', size=6)
    return(p)
  }
  else {
    df <- subset(df, native_country %in% allCoun)
    
    # Sort in order to have smaller colors displayed on top of the bigger colors
    df <- df[order(df[,sizeIndex], decreasing = TRUE),]
    
    # Create actual bubble plot
    p <- ggplot(df, aes_string(x = x, y = y))
    
    # Set a rectangle
    p <- p + xlim(xmin, xmax) + ylim(ymin, ymax)
    p <- p + geom_point(aes_string(size = sizeBy, color = "continents"), alpha = 0.8)
    
    # Option of having a country name
    if(abbrev){
      p <- p + geom_text(aes(label = native_country), col="#000000", hjust=0.5, vjust=0)  
    }
    
    # Default size scale is by radius, force to scale by area instead
    p <- p + scale_size_area(max_size = 20, guide = "none")
    
    # Modify axes
    p <- p + xlab(varnames2[which(colnames2 == x)]) +
      ylab(varnames2[which(colnames2 == y)])
    p <- p + theme(axis.title=element_text(face="bold.italic", size=16, color="brown"))
    p <- p + scale_x_continuous(
      limits = range(xmin, xmax),
      expand = c(0, 0))
    p <- p + scale_y_continuous(
      limits = c(ymin, ymax),
      expand = c(0, 0))
    p <- p + theme(axis.text = element_text(face="bold", size=12))
    
    # Modify panel
    p <- p + theme(panel.border = element_rect(fill = NA, colour = "black"))
    p <- p + theme(panel.background = element_blank())
    p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
      
    # Modify the legend settings
    p <- p + theme(legend.title = element_blank())
    p <- p + theme(legend.direction = "horizontal")
    p <- p + theme(legend.position = "top")
  #   p <- p + theme(legend.justification = c(1, 0))
    p <- p + theme(legend.background = element_blank())
    p <- p + theme(legend.key = element_blank())
    p <- p + theme(legend.text = element_text(face="bold", size=14))
    #   p <- p + theme(legend.margin = unit(0, "pt"))
    
    # Force the dots to plot larger in legend
    p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
    
    # Consistent color and fill
    p <- p + scale_colour_discrete(limits = c("Asia", "Europe", "North America", "South America"))
#     p <- p + scale_fill_discrete(limits = c("Asia", "Europe", "North America", "South America"))
    
    return(p)
  }
}

#### Create heat map ####
heatheat <- function(x2, hl, midrange) {
  # heatheat("Highest Degree in Education", T, c(0.45, 0.55))
  # http://stackoverflow.com/questions/12998372/heatmap-like-plot-but-for-categorical-variables
  if (x2 == "Highest Degree in Education")
    (df <- melt4e)
  else if (x2 == "Occupation")
    (df <- melt4o)
  else
    (df <- melt4w)
  
  p <- ggplot(df, aes(x=variable, y=native_country))
  p <- p + geom_tile(aes(fill = value), colour = "white")
#   p <- p + theme_minimal()
  
  # Modify axes
  p <- p + xlab(x2)
  p <- p + ylab("Native Country")
  p <- p + theme(axis.text.x = element_text(face="bold", angle = 45, hjust = 1))
  p <- p + theme(axis.title=element_text(face="bold.italic", size=16, color="brown"))
  
  # Modify the legend settings
  p <- p + theme(legend.text = element_text(size = 12))
  p <- p + theme(legend.position = c(-0.05, -0.175))
  
  # Diverging color scale from colorbrewer
  # #008837 is green, #7b3294 is purple
  palette <- c("#008837", "#f7f7f7", "#f7f7f7", "#7b3294")

  if(midrange[1] == midrange[2]) {
    # use a 3 color gradient instead
    p <- p + scale_fill_gradient2(low = palette[1], mid = palette[2], high = palette[4], midpoint = midrange[1])
  }
  else {
    # use a 4 color gradient (with a swath of white in the middle)
    p <- p + scale_fill_gradientn(colours = palette, values = c(0, midrange[1], midrange[2], 1))
  }
  
  # Highlight
  # https://groups.google.com/forum/#!topic/ggplot2/X6Dpjw67z4c
  if (hl)
    {
    if (x2 == "Highest Degree in Education")
      (p <- p + geom_rect(fill="#fff5f0", xmin = 0.5, xmax = 16.5, ymin = 0.5, ymax = 41.5) +
         geom_rect(fill="#fc9272", xmin = 11.5, xmax = 12.5, ymin = 0.5, ymax = 41.5) + 
         geom_rect(fill="#fc9272", xmin = 0.5, xmax = 16.5, ymin = 26.5, ymax = 27.5) +
         geom_rect(fill="#67000d", xmin = 11.5, xmax = 12.5, ymin = 26.5, ymax = 27.5) +
         theme(legend.position = "none"))
    else if (x2 == "Occupation")
      (p <- p + geom_rect(fill="#fff5f0", xmin = 0.5, xmax = 14.5, ymin = 0.5, ymax = 41.5) +
         geom_rect(fill="#fc9272", xmin = 6.5, xmax = 7.5, ymin = 0.5, ymax = 41.5) + 
         geom_rect(fill="#fc9272", xmin = 0.5, xmax = 14.5, ymin = 26.5, ymax = 27.5) +
         geom_rect(fill="#67000d", xmin = 6.5, xmax = 7.5, ymin = 26.5, ymax = 27.5) +
         theme(legend.position = "none"))
    else
      (p <- p + geom_rect(fill="#fff5f0", xmin = 0.5, xmax = 7.5, ymin = 0.5, ymax = 41.5) +
         geom_rect(fill="#67000d", xmin = 2.5, xmax = 3.5, ymin = 0.5, ymax = 41.5) +
         theme(legend.position = "none"))
    }
  else
    {p <- p}
  
  return(p)
}


#### Create density plot ####
densitydensity <- function(x3) {
# densitydensity("Age")
  df <- data1
  x <- colnames1[which(varnames1 == x3)] # "Age", "Years of Education"
  xIndex <- which(colnames1 == x)
  
  # Create actual density plot
  p <- ggplot(data1, aes_string(x = x,
        group = "income", color = "income", fill = "income"))  
  p <- p + geom_density(alpha=0.8)
  p <- p + facet_grid(sex ~ race) # "marital_status", "race", "relationship", "sex"
#   p <- p + geom_density(aes(y = ..count..), alpha=0.8)
  
  # Modify axes
  p <- p + xlab(varnames1[which(colnames1 == x)])
  p <- p + theme(axis.title=element_text(face="bold.italic", size=16, color="brown"))
  
  # Modify panel
  p <- p + theme(panel.border = element_rect(fill = NA, colour = "black"))
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
  
  # Modify the legend settings
  p <- p + theme(legend.text = element_text(size = 12))
  
  # Qualitative color scale from colorbrewer
  # #1b9e77 is lime green, #7570b3 is slightly desaturated blue.
  palette <- c("#1b9e77", "#7570b3")
  p <- p + scale_colour_manual(values = palette, name="Income per person")
  p <- p + scale_fill_manual(values = palette, name="Income per person")
  
  return(p)
}


#### Create overview plot ####
ovov <- function(x3) {
  # ovov("Age")
  df <- data1
  x <- colnames1[which(varnames1 == x3)] # "Age", "Years of Education"
  xIndex <- which(colnames1 == x)
  
  # Create actual density plot
  p <- ggplot(data1, aes_string(x = x,
                                group = "income", color = "income", fill = "income"))  
  p <- p + geom_density(alpha=0.8)
  
  # Modify axes
  p <- p + xlab(varnames1[which(colnames1 == x)])
  p <- p + theme(axis.title=element_text(face="bold.italic", size=16, color="brown"))
  
  # Modify panel
  p <- p + theme(panel.border = element_rect(fill = NA, colour = "black"))
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
  
  # Modify the legend settings
  p <- p + theme(legend.position = "none")
  
  # Qualitative color scale from colorbrewer
  # #1b9e77 is lime green, #7570b3 is slightly desaturated blue.
  palette <- c("#1b9e77", "#7570b3")
  p <- p + scale_colour_manual(values = palette, name="Income per person")
  p <- p + scale_fill_manual(values = palette, name="Income per person")
  
  return(p)
}

#### Create bar plot ####
barbar <- function(y4, ratio=F) {
  # barbar("Highest Degree in Education", F)
  # "Highest Degree in Education", "Marital Status", "Occupation", "Relationship", "Race", "Sex", "Work Class"
  
  df <- data3
  # I am going to flip axes later for a new experience.
  # So that is why x and y are named differently.
  x <- colnames1[which(varnames1 == y4)]
  xIndex <- which(colnames1 == x)
  
  # Create actual bar plot
  p <- ggplot(data3, aes_string(x = x, fill="income"))
  if (ratio) {p <- p + geom_bar(position="fill") + ylab("Percentage")}
  else {p <- p + geom_bar() + ylab("Count")}
  
  # Modify axes
  p <- p + xlab(varnames1[which(colnames1 == x)])
  p <- p + theme(axis.title=element_text(face="bold.italic", size=16, color="brown"))
  p <- p + theme(axis.text = element_text(face="bold", size=12))
  
  # Flip axes
  p <- p + coord_flip()
  
  # Modify panel
  p <- p + theme(panel.border = element_rect(fill = NA, colour = "black"))
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
  
  # Modify the legend settings
  p <- p + theme(legend.text = element_text(size = 12))
  
  # Qualitative color scale from colorbrewer
  # #1b9e77 is lime green, #7570b3 is slightly desaturated blue.
  palette <- c("#1b9e77", "#7570b3")
  p <- p + scale_fill_manual(values = palette, name="Income per person")

  # Get rid of space below zero
  p <- p + scale_y_continuous(expand = c(0,0))
  return(p)
}
