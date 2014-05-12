setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\final")
library(e1071)
library(ggplot2)
library(plyr)
library(RColorBrewer)
library(reshape2)
library(scales)
library(shiny)


# data1 <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", sep=",", header=F, na.strings=" ?")
data1 <- read.table("adult.data", sep=",", header=F, na.strings=" ?")
data1 <- na.omit(data1)
# table(data1[,length(data1)])
colnames(data1) <- c("age", "workclass", "fnlwgt", "education", "education_num",
                     "marital_status", "occupation", "relationship", "race", "sex",
                     "capital_gain", "capital_loss", "hours_per_week", "native_country", "income")
data1 <- data1[,-3]
levels(data1$native_country) <- c("Cambodia", "Canada", "China", "Columbia",
                          "Cuba", "Dominican Republic", "Ecuador", "El Salvador",
                          "England", "France", "Germany", "Greece",
                          "Guatemala", "Haiti", "Netherlands", "Honduras",
                          "Hong Kong", "Hungary", "India", "Iran",
                          "Ireland", "Italy", "Jamaica", "Japan",            
                          "Laos", "Mexico", "Nicaragua", "Guam and USVI",
                          "Peru", "Philippines", "Poland", "Portugal",
                          "Puerto Rico", "Scotland", "South Korea", "Taiwan",
                          "Thailand", "Trinadad&Tobago", "United States", "Vietnam",
                          "Yugoslavia")
# data1$native_country <- factor(data1$native_country, levels=names(sort(table(data1$native_country), dec=T)))
levels(data1$race) <- c("Native_Amer", "Asian", "Black", "Other", "White")
data1$race <- factor(data1$race, levels=levels(data1$race)[c(2,3,1,5,4)])
data1$education <- factor(data1$education, levels=levels(data1$education)[c(14,4,5,6,7,1,2,3,12,9,8,16,10,13,15,11)])
levels(data1$relationship) <- c("Husband", "Not_in_family", "Other", "Own_child",
                              "Unmarried", "Wife")
data1$relationship <- factor(data1$relationship, levels=levels(data1$relationship)[c(1,2,4,6,5,3)])
levels(data1$workclass) <- c("Federal_gov", "Local_gov", "Never_worked", "Private",
                             "Self_emp_inc", "Self_emp_not_inc", "State_gov", "Without_pay")
levels(data1$marital_status) <- c("Divorced", "Married_to_Armed_Forces", "Married_to_civilian",
                                  "Married_spouse_absent", "Never_married", "Separated", "Widowed")


data3 <- data1
data3$education <- factor(data3$education, levels=names(sort(table(data3$education), dec=T)))
data3$workclass <- factor(data3$workclass, levels=names(sort(table(data3$workclass), dec=T)))
data3$marital_status <- factor(data3$marital_status, levels=names(sort(table(data3$marital_status), dec=T)))
data3$occupation <- factor(data3$occupation, levels=names(sort(table(data3$occupation), dec=T)))
data3$relationship <- factor(data3$relationship, levels=names(sort(table(data3$relationship), dec=T)))
data3$race <- factor(data3$race, levels=names(sort(table(data3$race), dec=T)))
data3$sex <- factor(data3$sex, levels=names(sort(table(data3$sex), dec=T)))
data3$native_country <- factor(data3$native_country, levels=sort(data3$native_country, dec=T))



num_df <- data1[,c(1,4,10,11,12)]
char_df <- data1[,c(2,3,5,6,7,8,9,13,14)]


#### colnames vs variable names in data2 ####
colnames1 <- colnames(data1)
varnames1 <- c("Age", "Work Class", "Highest Degree in Education",      
                "Years of Education",  "Marital Status", "Occupation", "Relationship",
                "Race", "Sex", "Capital Gain", "Capital Loss",
                "Work Hours per Week", "Native Country", "Income")


data2 <- ddply(data1, .(native_country), summarize,
               mean_age = round(mean(age), 2),
#                mean_fnlwgt = round(mean(fnlwgt), 2),
               mean_education_num = round(mean(education_num), 2),
               mean_capital_gain = round(mean(capital_gain), 2),
               mean_capital_loss = round(mean(capital_loss), 2),
               mean_hours_per_week = round(mean(hours_per_week), 2))
data2 <- data2[-28,]
data2$continents <- c("Asia", "North America", "Asia", "South America",
                      "North America", "North America",
                      "South America", "North America", "Europe", "Europe",
                      "Europe", "Europe", "North America", "North America",
                      "Europe", "North America", "Asia", "Europe",
                      "Asia", "Asia", "Europe", "Europe",
                      "North America", "Asia", "Asia", "North America",
                      "North America", "South America", "Asia",
                      "Europe", "Europe", "North America", "Europe",
                      "Asia", "Asia", "Asia", "South America",
                      "North America", "Asia", "Europe")
data2$continents <- as.factor(data2$continents)
data2$native_country <- as.character(data2$native_country)
# data2$native_country <- c("Cambodia", "Canada", "China", "Columbia",
#                           "Cuba", "Dominican Republic", "Ecuador", "El Salvador",
#                           "England", "France", "Germany", "Greece",
#                           "Guatemala", "Haiti", "Netherlands", "Honduras",
#                           "Hong Kong", "Hungary", "India", "Iran",
#                           "Ireland", "Italy", "Jamaica", "Japan",            
#                           "Laos", "Mexico", "Nicaragua",
#                           "Peru", "Philippines", "Poland", "Portugal",
#                           "Puerto Rico", "Scotland", "South Korea", "Taiwan",
#                           "Thailand", "Trinadad&Tobago", "United States", "Vietnam",
#                           "Yugoslavia")
data2$native_country <- as.factor(data2$native_country)

#### subsetting by continents ####
# data2a <- data2[data2$continents == "Asia",]
# data2e <- data2[data2$continents == "Europe",]
# data2na <- data2[data2$continents == "North America",]
# data2sa <- data2[data2$continents == "South America",]

#### colnames vs variable names in data2 ####
colnames2 <- colnames(data2)
varnames2 <- c("native_country", "Mean Age",
              "Mean Education Years", "Mean Capital Gain", "Mean Capital Loss",
              "Mean Hours per Week", "continents")




#### Create bubble plot ####
bubblebubble <- function(x, y, sizeBy, abbrev, aCoun, eCoun, naCoun, saCoun, colScheme) {
#   bubblebubble("Mean Education Years", "Mean Hours per Week", "Mean Age", T, "all", "all", "all", "all", "Set1")
  df <- data2
#   dfa <- data2a
#   dfe <- data2e
#   dfna <- data2na
#   dfsa <- data2sa
  x <- colnames2[which(varnames2 == x)]
  y <- colnames2[which(varnames2 == y)]
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
    p <- p + theme(axis.title=element_text(face="bold.italic", size="12", color="brown"))
    p <- p + scale_x_continuous(
      limits = range(xmin, xmax),
      expand = c(0, 0))
    p <- p + scale_y_continuous(
      limits = c(ymin, ymax),
      expand = c(0, 0))
    
    # Modify panel
    p <- p + theme(panel.border = element_rect(
      fill = NA, colour = "black"))
    p <- p + theme(panel.background = element_blank())
    p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
  
    
    # Modify the legend settings
    p <- p + theme(legend.title = element_blank())
    p <- p + theme(legend.direction = "horizontal")
    p <- p + theme(legend.position = "top")
  #   p <- p + theme(legend.justification = c(1, 0))
    p <- p + theme(legend.background = element_blank())
    p <- p + theme(legend.key = element_blank())
    p <- p + theme(legend.text = element_text(size = 12))
    #   p <- p + theme(legend.margin = unit(0, "pt"))
    
  
    # Force the dots to plot larger in legend
    p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
    
    return(p)
  }
}


heatheat <- function(x) {
  # heatheat("Highest Degree in Education")
  df <- data1
  x <- colnames1[which(varnames1 == "Highest Degree in Education")]
  xIndex <- which(colnames1 == x)
  
  # Create actual heatmap
  p <- ggplot(df, aes_string(x=x, y="native_country"))
  p <- p + geom_tile(colour = "white")
#   p <- p + theme_minimal()
  
  
#   palette <- c("#008837", "#f7f7f7", "#f7f7f7", "#7b3294")
#   p <- p + scale_fill_gradient2(low = palette[1], mid = palette[2], high = palette[4], midpoint = 0.5)
  
  # Modify axes
  p <- p + xlab(varnames1[which(colnames1 == x)])
  p <- p + ylab("Native Country")
  p <- p + theme(axis.text.x = element_text(angle = 45, hjust = 1))
  p <- p + theme(axis.title=element_text(face="bold.italic", size="12", color="brown"))
  
  # Modify panel
#   p <- p + theme(panel.border = element_rect(
#     fill = NA, colour = "black"))
#   p <- p + theme(panel.background = element_blank())
#   p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
#   
#   p <- p + scale_size_area(max_size = 20, guide = "none")
  return(p)
}


densitydensity <- function(x) {
# densitydensity("Age")
  df <- data1
  x <- colnames1[which(varnames1 == "Years of Education")] # "Age", "Years of Education"
  xIndex <- which(colnames1 == x)
  
  # Create actual density plot
  p <- ggplot(data1, aes_string(x = x,
        group = "income", color = "income", fill = "income"))  
  p <- p + geom_density(alpha=0.8)
  p <- p + facet_grid(sex ~ race) # "marital_status", "race", "relationship", "sex"
#   p <- p + geom_density(aes(y = ..count..), alpha=0.8)
  
  # Modify axes
  p <- p + xlab(varnames1[which(colnames1 == x)])
  p <- p + theme(axis.title=element_text(face="bold.italic", size="12", color="brown"))
  
  # Modify panel
  p <- p + theme(panel.border = element_rect(
    fill = NA, colour = "black"))
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
  
  p <- p + scale_size_area(max_size = 20, guide = "none")
  return(p)
}


barbar <- function(x, ratio=F) {
  # barbar("Highest Degree in Education", F)
  # "Work Class", "Highest Degree in Education", "Marital Status", "Occupation",
  # "Relationship", "Race", "Sex"
  df <- data3
  x <- colnames1[which(varnames1 == "Highest Degree in Education")]
  xIndex <- which(colnames1 == x)
  
  # Create actual bar plot
  p <- ggplot(data3, aes_string(x = x, fill="income"))
  if (ratio) {p <- p + geom_bar(position="fill")}
  else {p <- p + geom_bar()}
  
  # Modify axes
  p <- p + xlab(varnames1[which(colnames1 == x)])
  p <- p + theme(axis.title=element_text(face="bold.italic", size="12", color="brown"))
  
  # Flip axes
  p <- p + coord_flip()
  
  # Modify panel
  p <- p + theme(panel.border = element_rect(
    fill = NA, colour = "black"))
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.grid.major = element_line(colour="blue", linetype="dashed"))
  
  p <- p + scale_size_area(max_size = 20, guide = "none")
  return(p)
}