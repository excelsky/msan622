#setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\3due0410j")
library(GGally)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(shiny)
# Objects defined outside of shinyServer() are visible to
# all sessions. Objects defined instead of shinyServer()
# are created per session. Place large shared data outside
# and modify (filter/sort) local copies inside shinyServer().


# Loads global data to be shared by all sessions.
loadData <- function() {
  df <- data.frame(state.x77,
                   State = state.name,
                   Abbrev = state.abb,
                   Region = state.region,
                   Division = state.division
  )
  
  # Convert to factors.
  df$State <- as.factor(df$State)
  df$Abbrev <- as.factor(df$Abbrev)
  df$Region <- as.factor(df$Region)
  df$Division <- as.factor(df$Division)
  
  # Add a population density
  df$Pop.Density <- df$Population / df$Area
  
  return(df)
}

# Label formatter for numbers in millions.
million_formatter <- function(x) {
  return(sprintf("%dk", round(x / 1000000)))
}


#### Create bubble plot ####
getBubblePlot <- function(df, x, y, sizeBy, colorBy, abbrev) {
#   getBubblePlot(df2, "Population", "Income", "Population", "Region", T)
  
  # Get indices for aesthetics in ggplot to be used
#   xIndex <- which(colnames(df) == x)
#   yIndex <- which(colnames(df) == y)
  sizeIndex <- which(colnames(df) == sizeBy)
#   colorIndex <- which(colnames(df) == colorBy) 
  
  # Sort in order to have smaller colors displayed on top of the bigger colors
  df <- df[order(df[,sizeIndex], decreasing = TRUE),]
  
  # Create actual bubble plot
#   p <- ggplot(df, aes_string(x = df[,xIndex], y = df[,yIndex])) +
#     geom_point(aes_string(size = df[,sizeIndex], color = df[,colorIndex]), alpha = 0.8)
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
  
  # Indicate size is bubble size
#   p <- p + annotate(
# #     "text", x = 6, y = 4.8,
#     "text", x = 600, y = 960,
#     hjust = 0.5, color = "grey40",
#     label = "Circle area is proportional to the 'Bubble Size'")
    
  
  return(p)
}

#### Create scatter plot matrix ####
getScatterPlotMatrix <- function(df, variables, colorBy1){
# getScatterPlotMatrix(df2, c("Population", "Income"), "Region")  
# getScatterPlotMatrix(df2, c("Population", "Income", "Murder"), "Division")  
  
  # Get indices in columns and variables
  idx <- 1:ncol(df)
  variableIndex <- idx[colnames(df) %in% variables]
  
  if (length(variableIndex) < 1) {
    df <- data.frame(ex = 0, wy = 0,
                     labels = "Please, choose at least one variable.\n
                     Or, if you know how to generate\n
                     a scatterplot matrix with only one variable,\n
                     please let me know.\n
                     I am willing to learn from you.")
    p <- ggplot(df) +
      geom_text(aes(x=ex, y=wy, label = labels), size=15) +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank())
  }
  else{
    p <- ggpairs(df, 
               
               # Columns to include in the matrix
               columns = variableIndex,
               
               # What to include above diagonal
               # list(continuous = "points") to mirror
               # "blank" to turn off
               upper = "blank",
               
               # What to include below diagonal
               lower = list(continuous = "points"),
               
               # What to include in the diagonal
               diag = list(continuous = "density"),
               
               # How to label inner plots
               # internal, none, show
               axisLabels = "none",
               
               # Other aes() parameters
               colour = colorBy1,
               title = "Scatterplot Matrix",
               legends=T
    ) # ggpairs
#     +  guides(colour = guide_legend("colorBy1"))
    
    # Create a (representative) legend (rather than individual ones)
    # I got the following code from StackOverFlow
    # http://stackoverflow.com/questions/22945702/how-to-add-an-external-legend-to-ggpairs
    for (i in 1:length(variableIndex)) {
      # Address only the diagonal elements
      # Get plot out of matrix
      inner <- getPlot(p, i, i);
      # Add any ggplot2 settings you want
      inner <- inner + theme(panel.grid = element_blank()) +
        theme(axis.text.x = element_blank())
      # Put it back into the matrix
      p <- putPlot(p, inner, i, i)
      
      for (j in 1:length(variableIndex)){
        if((i==1 & j==1)){
          inner <- getPlot(p, i, j)
          inner <- inner + theme(legend.position=c(length(variableIndex)-0.25,0.50)) 
          p <- putPlot(p, inner, i, j)
        }
        else{
          inner <- getPlot(p, i, j)
          inner <- inner + theme(legend.position="none")
          p <- putPlot(p, inner, i, j)
        }
      }
    }
    
    
  }
  return(p)
}

#### Create parallel coordinates plot ####
getPCP <- function(df, variables2, colorBy2, colorScheme, opacity, scaling) {
# getPCP(df2, c("Population", "Income"), "Region", "Default", 0.8, "robust")
# getPCP(df2, c("Population", "Income", "Murder"), "Division", "Set1", 0.8, "std")
  
  variableIndex <- (1:ncol(df))[colnames(df) %in% variables2]
  colorIndex <- (1:ncol(df))[colnames(df) == colorBy2]
  
  if (length(variableIndex) <= 1){
    df <- data.frame(ex = 0, wy = 0,
                     labels = "Please, choose at least two variables.\n
                     Or, if you know how to generate\n
                     a parallel coordinates plot with only two variables,\n
                     please let me know.\n
                     I am willing to learn from you.")
    p <- ggplot(df) +
      geom_text(aes(x=ex, y=wy, label = labels), size=12) +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank())
  }
  else{
  p <- ggparcoord(data = df,                   
                  # Which columns to use in the plot
                  columns = variableIndex,                   
                  # Which column to use for coloring data
                  groupColumn = colorIndex,                   
                  # Allows order of vertical bars to be modified
                  order = "anyClass",                  
                  # Do not show points
                  showPoints = FALSE,                  
                  # Turn on alpha blending for dense plots
                  alphaLines = opacity,                  
                  # Turn off box shading range
                  shadeBox = NULL,                  
                  # Will normalize each column's values to [0, 1]
                  scale = scaling
  )  
  # Start with a basic theme
  p <- p + theme_minimal()  
  
  # Decrease amount of margin around x, y values
  p <- p + scale_y_continuous(expand = c(0.02, 0.02))
  p <- p + scale_x_discrete(expand = c(0.02, 0.02))  
  
  # Remove axis ticks and labels
  p <- p + theme(axis.ticks = element_blank())
  p <- p + theme(axis.title = element_blank())
  p <- p + theme(axis.text.y = element_blank())  
  
  # Clear axis lines
  p <- p + theme(panel.grid.minor = element_blank())
  p <- p + theme(panel.grid.major.y = element_blank())  
  
  # Darken vertical lines
  p <- p + theme(panel.grid.major.x = element_line(color = "#bbbbbb"))  
  
  # Move label to bottom
  p <- p + theme(legend.position = "bottom") + scale_color_brewer(palette = colorScheme)  
  
#   # Figure out y-axis range after GGally scales the data
#   min_y <- min(p$data$value)
#   max_y <- max(p$data$value)
#   pad_y <- (max_y - min_y) * 0.1  
#   
#   # Calculate label positions for each veritcal bar
#   lab_x <- rep(colnames(df)[variableIndex], times = 2) # 2 times, 1 for min 1 for max
#   lab_y <- rep(c(min_y - pad_y, max_y + pad_y), each = 4)  
#   
#   # Get min and max values from original dataset
#   lab_z <- c(sapply(df[,variableIndex], min), sapply(df[,variableIndex], max))  
#   
#   # Convert to character for use as labels
#   lab_z <- as.character(lab_z)  
#   
#   # Add labels to plot
#   p <- p + annotate("text", x = lab_x, y = lab_y, label = lab_z, size = 3)
  

   p <- p + scale_colour_discrete(limits = levels(df[,colorIndex]))
  } # else
  return(p)
}

##### GLOBAL OBJECTS #####

# Shared data
globalData <- loadData()

# Color-blind friendly palette from http://jfly.iam.u-tokyo.ac.jp/color/
palette1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
              "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


# Create labeler function that removes dots and
# capitalizes the first letter
niceLabels <- function(text) {
  text <- gsub("\\.", " ", text)
  text <- paste(
    toupper(substr(text, 1, 1)), 
    substring(text, 2),
    sep = "",
    collapse = "")
  return(text)
}

##### SHINY SERVER #####

# Create shiny server. Input comes from the UI input controls,
# and the resulting output will be displayed on the page.
shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
  # Copy the data frame (don't want to change the data
  # frame for other viewers)
  df <- globalData
  
  filter_color <- reactive({
    switch(input$colorScheme,
           "Default" = "Default",
           "Accent" = "Accent",
           "Set1" = "Set1",
           "Set2" = "Set2",
           "Set3" = "Set3",
           "Dark2" = "Dark2",
           "Pastel1" = "Pastel1",
           "Pastel2" = "Pastel2")
  })

#### Render bubble plot ####
  output$BP <- renderPlot({
    
    # Use our function to generate the plot
    bubblePlot <- getBubblePlot(
      df, x=input$x, y=input$y, sizeBy=input$sizeBy, colorBy=input$colorBy, abbrev=input$abbrev
    )  # getBubblePlot
    
    # Output the plot
    print(bubblePlot)},
                           
    height = 800, width = 1200) # renderPlot of "Bubble Plot"

#### Render Scatterplot Matrix ####
  output$SPM <- renderPlot({

    # Use our function to generate the plot
    scatterPlotMatrix <- getScatterPlotMatrix(
      df, variables=input$variables, colorBy1=input$colorBy1
    )  # getScatterPlotMatrix
    
    # Output the plot
    print(scatterPlotMatrix)},
  
    height = 800, width = 1200) # renderPlot of "Scatter Plot Matrix "
  
#### Render Parallel Coordinates Plot ####
  output$PCP <- renderPlot({

  # Use our function to generate the plot
  parallelcoordinatesPlot <- getPCP(
    df, variables2=input$variables2, colorBy2=input$colorBy2,
    colorScheme=input$colorScheme, opacity=input$opacity, scaling=input$scaling
  )  # getPCP
  
  # Output the plot
  print(parallelcoordinatesPlot)},

  height = 750, width = 1000)  # renderPlot of "Parallel Coordinates Plot"
})
