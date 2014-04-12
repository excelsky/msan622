library(shiny)
#### shinyUI ####
shinyUI(
  # Create a page with a top level navigation bar
  navbarPage("Choose a Plot",
#### Bubble Plot ####
    navbarMenu("Heapmat -or- Bubble Plot",
      tabPanel("I chose a Bubble Plot",
        # Layout a sidebar and main area
        sidebarLayout(
          # Create a sidebar panel
          sidebarPanel(
            # Create a well panel
            wellPanel(
              selectInput("x", "X axis",
                          c("Population",
                           "Income",
                            "Illiteracy",
                            "Life.Exp",
                            "Murder",
                            "HS.Grad",
                            "Frost",
                            "Area"), selected = "Population"
              ),  # selectInput
              
              # Add a little bit of space between widgets
              br(),
              
              selectInput("y", "Y axis",
                          c("Population",
                            "Income",
                            "Illiteracy",
                            "Life.Exp",
                            "Murder",
                            "HS.Grad",
                            "Frost",
                            "Area"), selected = "Income"
              )  # selectInput
            ),  # wellPanel
            
            # Create a well panel
            wellPanel(
              # Create a select list input control
              selectInput("sizeBy", "Bubble Size",
                          c("Population", "Income", "Area", "Pop.Density"),
                          selected = "Population"
              ),  # selectInput
              # Checkbox Input Control
              checkboxInput("abbrev","State Abbreviation", value=TRUE
              )  # checkboxInput
            ),  # wellPanel
            
            # Create a well panel
            wellPanel(
              # Create radio buttons
              radioButtons("colorBy", "Color by:",
                           c("Region", "Division"),
                           selected = "Region"
              )  # radioButtons
              
#               # Checkbox Group Input Control
#               checkboxGroupInput("filterRegions", "Filter regions", 
#                                  c("Northeast", "South", "West", "North Central"),
# #                                  selected = c("Northeast", "South", "West", "North Central")
#                                  selected = c()
#               )  # checkboxGroupInput
            )  # wellPanel
          ), # sidebarPanel
          
          # Setup main panel.
          mainPanel(
            # Create a tabset pane
            tabsetPanel(
              # Create a tab panel
              tabPanel("Bubble Plot",
                       plotOutput("BP", width = "100%", height = "100%")
              )  # tabPanel  
            )  # tabsetPanel
          )  # mainPanel
          
        )  # sidebarLayout
      ),  # tabPanel of "Bubble Plot"
#     ),  # navbarMenu of "Bubble Plot -or- Heapmat"

#### Heatmap ####             
      tabPanel("Heatmap (Please do not click)",
        # Layout a sidebar and main area
        sidebarLayout(
          # Create a sidebar panel
          sidebarPanel(
            # Create a well panel
            wellPanel(
            )  # wellPanel
          ),  # sidebarPanel
         
          # Setup main panel.
          mainPanel(
            # Create a tabset pane
            tabsetPanel(
              # Create a tab panel
              tabPanel("Heatmap",
                      plotOutput("heatMap", width = "100%", height = "100%")
              )  # tabPanel  
            )  # tabsetPanel
          )  # mainPanel
         
        )  # sidebarLayout
      )  # tabPanel of "Heatmap"
    ),  # navbarMenu of "Bubble Plot -or- Heapmat"

#### Scatterplot Matrix ####                
    # Create a page with a top level navigation bar.
    navbarMenu("Scatterplot Matrix -or- Small Multiples",
      tabPanel("I chose a Scatterplot Matrix",
        # Layout a sidebar and main area
        sidebarLayout(
          # Create a sidebar panel
          sidebarPanel(
            # Create a well panel
            wellPanel(
              # Checkbox Group Input Control
              checkboxGroupInput("variables", "Choose variables:", 
                                 c("Population",
                                   "Income",
                                   "Illiteracy",
                                   "Life.Exp",
                                   "Murder",
                                   "HS.Grad",
                                   "Frost",
                                   "Area")
                                 , selected = c("Population", "Income")
              ),  # checkboxGroupInput
              
              # Add a little bit of space between widgets
              br(),
              
              # Create radio buttons.
              radioButtons("colorBy1", "Color by:",
                           c("Region", "Division"),
                           selected = "Region"
              )  # radioButtons
                       
            )  # wellPanel
          ),  # sidebarPanel
          
          # Setup main panel.
          mainPanel(plotOutput("SPM", width = "100%", height = "100%")
          )  # mainPanel
        )  # sidebarLayout
      ),  # tabPanel
#     ),  # navbarMenu of "Scatterplot Matrix -or- Small Multiples"

#### small multiples ####               
      tabPanel("Small Multiples (Please do not click)",
        # Layout a sidebar and main area
        sidebarLayout(
          # Create a sidebar panel
          sidebarPanel(width=2.5,
            # Create a well panel
            wellPanel(
            )  # wellPanel
          ),  # sidebarPanel
          
          # Setup main panel
          mainPanel(
            # Create a tabset pane
            tabsetPanel(
              # Create a tab panel
              tabPanel("Small Multiples",
                       plotOutput("Small Multiples", width = "100%", height = "100%")
              )  # tabPanel  
            )  # tabsetPanel
          )  # mainPanel
          
        )  # sidebarLayout
      )  # tabPanel
    ),  # navbarMenu of "Scatterplot Matrix -or- Small Multiples"

#### Parallel Coordinates Plot ####            
    # Create a tab panel
    tabPanel("Parallel Coordinates Plot",
      # Layout a sidebar and main area
      sidebarLayout(
        # Create a sidebar panel
        sidebarPanel(
          wellPanel(
            # Checkbox Group Input Control
            checkboxGroupInput("variables2", "Choose variables:", 
                               c("Population",
                                 "Income",
                                 "Illiteracy",
                                 "Life.Exp",
                                 "Murder",
                                 "HS.Grad",
                                 "Frost",
                                 "Area")
                               , selected = c("Population", "Income")
            )  # checkboxGroupInput
          ),  # wellPanel
          
          # Create a well panel
          wellPanel(
            # Create a select list input control
            selectInput("scaling", "Scaling:",
                        c("std", "robust", "uniminmax", "globalminmax", "center", "centerObs"),
                        selected="uniminmax"
            )  # selectInput
          ),  # wellPane
          
          # Create a well panel
          wellPanel(
            # Create a select list input control
            selectInput("colorScheme","Color Scheme:",
            c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2"),
            selected='Set1'
            ),  # selectInput
                     
          # Add a little bit of space between widgets
          br(),
           
          # Create radio buttons.
          radioButtons("colorBy2", "Color by:",
                        c("Region", "Division"),
                        selected = "Region"
          ),  # radioButtons
           
          # Add a little bit of space between widgets
          br(),
          
            # Slider Input Widget
            sliderInput("opacity", "Opacity:", 0.1, 1.0, 0.8, step=0.1
            )  # sliderInput
          )  # wellPanel                     
          
        ),  # sidebarPanel
        
        # Create a main panel
        mainPanel(
          # Create an plot output element
          plotOutput("PCP", width = "100%", height = "100%"
          )  # plotOutput
        )  # mainPanel
        
      )  # sidebarLayout
    )  # tabPanel of "Parallel Coordinates Plot"
             
  )  # navbarPage
)  # shinyUI
