library(shiny)

# Create a simple shiny page.
shinyUI(
  # We will create a page with a sidebar for input.
  pageWithSidebar(  
    # Add title panel.
    headerPanel("IMDB Movie Ratings"),
    
    # Setup sidebar widgets.
    sidebarPanel(
      # Add radio buttons for selecting the color scheme.
      # Can only select one radio button at a time.
      radioButtons(
        "mpaaRating", 
        "MPAA Rating:",
        c("All", "NC-17", "PG", "PG-13", "R")
      ),
      
      # Add a little bit of space between widgets.
      br(),
      
      # Add true/false checkbox for sorting.
      checkboxGroupInput(
        "movieGenres",
        "Movie Genres:",
#         c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short"),
        list("Action" = 1, "Animation" = 2, "Comedy" = 3, "Drama"=4, "Documentary"=5, "Romance"=6, "Short"=7),
        selected = c()
      ),
      
      # Add a little bit of space between widgets.
      br(),
      
      # Add a drop-down box for sort columns.
      selectInput(
        # This will be the variable we access later.
        "colorScheme", 
        # This will be the control title.
        "Color Scheme:", 
        # This will be the control choices.
        choices = c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2")
      ),
      
      # Add a little bit of space between widgets.
      br(),
      
      # Sidebar with a slider input for size of dots.
      sliderInput(
        "dotSize", 
        "Dot Size", 
        min = 1, 
        max = 10, 
        value = 3, 
        step = 1),
      
      # Add a little bit of space between widgets.
      br(),
      
      # Sidebar with a slider input for transparency (alpha) of dots.
      sliderInput(
        "dotAlpha", 
        "Dot Alpha", 
        min = 0.1, 
        max = 1, 
        value = 0.5, 
        step = 0.1),
      
      
      # Add a little bit of space between widgets.
      br(),
      # Add a little bit of space between widgets.
      br(),
      
      selectInput(
        # This will be the variable we access later.
        "sortColumn", 
        # This will be the control title.
        "Sort in Table", 
        # This will be the control choices.
        choices = c("Title", "Budget", "Genre", "Mpaa", "Length", "Rating", "Year")
      ),
      
            
      # Add a little bit of space between widgets.
      br(),
      
      checkboxInput(
        "sortDecreasing", 
        "Sort Decreasing in Table", 
        FALSE
      ),
      
      # Add a download link
      HTML("<p align=\"center\">[ <a href=\"https://github.com/excelsky/msan622/tree/master/homework2\">download source</a> ]</p>")
    ),
    
    # Setup main panel.
    mainPanel(
      # Create a tab panel.
      tabsetPanel(
        # Add a tab for displaying the histogram.
        tabPanel("Scatter Plot", plotOutput("scatterPlot",
                                            width = "800px", 
                                            height = "450px")),
        
        # Add a tab for displaying the table (will be sorted).
        tabPanel("Table", tableOutput("table"))
      )
    )  
  )
)