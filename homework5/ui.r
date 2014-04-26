shinyUI(pageWithSidebar(
  headerPanel("Road Casualties in Great Britain 1969 - 1984"),
  
  sidebarPanel(
    sliderInput(
      "num", 
      "Months:", 
      min = 4, 
      max = 24,
      value = 12, 
      step = 1
    ),
    
    # Add a little bit of space between widgets.
    br(),
    
    sliderInput(
      "start", 
      "Starting Point:",
      min = 1969, 
      max = 1984,
      value = 1969, 
      step = 1 / 12,
      round = FALSE, 
      ticks = TRUE,
      format = "####.##",
      animate = animationOptions(
        interval = 800, 
        loop = TRUE
      )
    ),
    
    # Add a little bit of space between widgets.
    br(),
    # Add a little bit of space between widgets.
    br(),
    
    # Checkbox Group Input Control
    checkboxGroupInput("SAPvar", "Variables for Stacked Area Plot:\n
                       (I wish I could force the color consistent.)", 
                       c("DriversKilled",
                         "front",
                         "rear")
                       , selected = c("DriversKilled",
                                      "front",
                                      "rear")
    ),  # checkboxGroupInput
    
    # Add a little bit of space between widgets.
    br(),
    
    # Create radio buttons.
    radioButtons("LPvar", "Variables for Line Plot:",
                 c("DriversKilled",
                   "front",
                   "rear"),
                 selected = "DriversKilled"
    ),  # radioButtons
    
    width = 3
  ),
  
  mainPanel(
    plotOutput(
      outputId = "mainPlot", 
      width = "100%", 
      height = "400px"
    ),
    
    plotOutput(
      outputId = "overviewPlot",
      width = "100%",
      height = "200px"
    ),
    
    width = 9
  )
))
