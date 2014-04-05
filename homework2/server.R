# setwd("D:\\USFCA\\6_Spring_Moduel_II\\622_Visualization\\HAG\\2due0403j")
library(ggplot2)
library(shiny)
library(scales)
# Objects defined outside of shinyServer() are visible to
# all sessions. Objects defined instead of shinyServer()
# are created per session. Place large shared data outside
# and modify (filter/sort) local copies inside shinyServer().

# See plot.r for more comments.

# Note: Formatting is such that code can easily be shown
# on the projector.

# Loads global data to be shared by all sessions.
loadData <- function() {
  data("movies", package = "ggplot2")
  
  # Filter out any rows that do not have a valid budget value greater than 0.
  movies <- subset(movies, budget > 0)
  
  # Filter out any rows that do not have a valid MPAA rating in the mpaa column.
  movies <- subset(movies, mpaa != "")
  
  # Add a genre column to the movies dataset as follows:
  genre <- rep(NA, nrow(movies))
  count <- rowSums(movies[, 18:24])
  genre[which(count > 1)] = "Mixed"
  genre[which(count < 1)] = "None"
  genre[which(count == 1 & movies$Action == 1)] = "Action"
  genre[which(count == 1 & movies$Animation == 1)] = "Animation"
  genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
  genre[which(count == 1 & movies$Drama == 1)] = "Drama"
  genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
  genre[which(count == 1 & movies$Romance == 1)] = "Romance"
  genre[which(count == 1 & movies$Short == 1)] = "Short"
  
  # Add genre to the dataset
  movies$genre <- genre
  
  # Filter out unnecessary columns.
  columns <- c("title", "budget", "genre", "mpaa", "length", "rating", "year")
  movies <- movies[columns]
  
  return(movies)
}

# Label formatter for numbers in millions.
million_formatter <- function(x) {
  return(sprintf("%dk", round(x / 1000000)))
}

# Create plotting function.
getPlot <- function(localFrame, mpaaRating, movieGenres, colorScheme="None", dotSize, dotAlpha) {
#   # Figure out sort order.
#   localFrame$Genres <- factor(
#     localFrame$Genres,
#     levels = localFrame$Genres[sortOrder])
  
  # Subset based on rating
  if (mpaaRating == "All") {}
  else {localFrame <- subset(localFrame, mpaa == mpaaRating)}
  
  # Subset based on genre
  genre_list <- c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short")
  genre_bool <- as.numeric(movieGenres)
  if (sum(genre_bool) > 0){
    localFrame <- subset(localFrame, genre %in% genre_list[genre_bool])
  }
  else {}
  
#   # Shape of the points
#   if (pointShape == "Solid Square"){shape <- 15}
#   else if (pointShape == "Solid Circle"){shape <- 16}
#   else if (pointShape == "Solid Triangle"){shape <- 17}
#   else if (pointShape == "Solid Diamond"){shape <- 18}
#   else if (pointShape == "Empty Square"){shape <- 0}
#   else if (pointShape == "Empty Circle"){shape <- 1}
#   else if (pointShape == "Empty Triangle"){shape <- 2}
#   else if (pointShape == "Empty Diamond"){shape <- 5}
#   else {shape <- 15}
  
  # Create base plot.
  localPlot <- ggplot(localFrame, aes(x = budget, y = rating, group=factor(mpaa), color=factor(mpaa))) +
    geom_point(alpha=dotAlpha, shape=22, size=dotSize) +
    ggtitle("Movies by Genre") +
    xlab("Budget (US $)") +
    ylab("IMDB Rating (1 to 10)") +
#     theme_grey() +
    scale_x_continuous(expand = c(0, 0), label = million_formatter, limits=c(0, 200000000)) +
    scale_y_continuous(breaks=0:10, expand=c(0,0), limits=c(0,10.5)) +
#     scale_color_brewer(palette=colorScheme, limits=levels(localFrame$mpaa), name="MPAA Rating") +
#     theme(panel.background = element_blank(), panel.grid = element_blank()) +
    theme(panel.grid.major.x = element_blank()) +
    theme(panel.grid.minor.y = element_blank()) +
    theme(axis.ticks.x = element_blank()) +
    theme(axis.text.x = element_text(size = rel(1.25))) +
    theme(axis.text.y = element_text(size = rel(1.25))) +
    labs(color="MPAA") + 
    theme(legend.justification = c(1, 1)) + 
    theme(legend.position = c(0.95, 0.13)) +
    theme(legend.direction = "horizontal") +
    theme(legend.key = element_rect(fill = "white")) +
    theme(legend.title = element_text(size = rel(1.25), face = "italic")) +
    theme(legend.text = element_text(face = "italic")) + 
    theme(text = element_text(size = 18))
  
  
#   if (mpaaRating == "Qualitative 1") {
#     localPlot <- localPlot +
#       scale_fill_brewer(type = "qual", palette = 1)
#   }
#   else if (mpaaRating == "Qualitative 2") {
#     localPlot <- localPlot +
#       scale_fill_brewer(type = "qual", palette = 2)
#   }
#   else if (mpaaRating == "Color-Blind Friendly") {
#     localPlot <- localPlot +
#       scale_fill_manual(values = palette1)
#   }
#   else {
#     localPlot <- localPlot +
#       scale_fill_grey(start = 0.4, end = 0.4)
#   }
  
  # Select color palette.
  if (colorScheme == "Default") {
    localPlot <- localPlot
  }
  else {
    localPlot <- localPlot +
      scale_color_brewer(palette = colorScheme)
  }
  
  return(localPlot)
}

# Create a table function.
# getTable <- function(localFrame) {
#   ordnung <- order(localFrame[,tolower(paste(input$sortColumn))], decreasing = input$sortDecreasing)
#   localFrame <- localFrame[ordnung, c("title", "year", "length", "budget", "rating", "mpaa", "genre")]
#   return(localFrame)
# }

##### GLOBAL OBJECTS #####

# Shared data
globalData <- loadData()

# Color-blind friendly palette from http://jfly.iam.u-tokyo.ac.jp/color/
palette1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
              "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

##### SHINY SERVER #####

# Create shiny server. Input comes from the UI input controls,
# and the resulting output will be displayed on the page.
shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
  # Copy the data frame (don't want to change the data
  # frame for other viewers)
  localFrame <- globalData
  
  # Output row order based on sorting criteria
  # Should update every time the sort column or descending
  # checkbox is changed. (Explain reactive functions.)
#   sortOrder <- reactive(
# {
#   if (input$sortColumn == "Genre") {
#     return(
#       order(
#         localFrame$Genres,
#         decreasing = input$sortDecreasing
#       )
#     )
#   }
#   else {
#     return(
#       order(
#         localFrame$Counts,
#         decreasing = input$sortDecreasing
#       )
#     )
#   }
# }
#   )
  
  # Choose what having no species selected should mean.
#   getHighlight <- reactive({
#     result <- levels(iris$Species)
#     
#     return(result[which(result %in% input$highlight)])
#     #         }
#   })
  
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
  
  # Output sorted table.
  # Should update every time sort order updates.
  output$table <- renderTable(
{
#   table <- getTable(localFrame, input$mpaa, input$genre)
  ordnung <- order(localFrame[,tolower(paste(input$sortColumn))], decreasing = input$sortDecreasing)
  localFrame <- localFrame[ordnung, c("title", "budget", "genre", "mpaa", "length", "rating", "year")]
  return(localFrame)
}
  )
  
  # Output sorted scatter plot.
  # Should update every time sort or color criteria changes.
  output$scatterPlot <- renderPlot(
{
  # Use our function to generate the plot.
  scatterPlot <- getPlot(
    localFrame,
    input$mpaaRating,
    input$movieGenres,
    filter_color(),
    input$dotSize,
    input$dotAlpha
  )
  
  # Output the plot
  print(scatterPlot)
}
  )
})
