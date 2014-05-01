library(shiny)
#### shinyUI ####
shinyUI(
  # Create a page with a top level navigation bar
  navbarPage("Census Income Data",
#### Bubble Plot ####
      tabPanel("Bubble Plot",
        sidebarLayout(
          sidebarPanel(
            wellPanel(
              selectInput("x", "X axis",
                          c("age",
                           "education_num",
                            "captial_gain",
                            "capital_loss",
                            "hours_per_week"),
                          selected = "age"
              ),  # selectInput
              br(),              
              selectInput("y", "Y axis",
                          c("age",
                            "education_num",
                            "captial_gain",
                            "capital_loss",
                            "hours_per_week"),
                          selected = "age"
              )  # selectInput
            ),  # wellPanel
            
            wellPanel(
              selectInput("sizeBy", "Bubble Size",
                          c("workclass",
                            "education",
                            "marital_status",
                            "occupation",
                            "relationship",
                            "race",
                            "sex",
                            "native_country"),
                          selected = "martial_status"
              ),  # selectInput
              
              checkboxInput("abbrev","State Abbreviation", value=TRUE
              )  # checkboxInput
              
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
      )  # tabPanel of "Bubble Plot"

# #### small multiples ####               
#       tabPanel("Small Multiples (Please do not click)",
#         # Layout a sidebar and main area
#         sidebarLayout(
#           # Create a sidebar panel
#           sidebarPanel(width=2.5,
#             # Create a well panel
#             wellPanel(
#             )  # wellPanel
#           ),  # sidebarPanel
#           
#           # Setup main panel
#           mainPanel(
#             # Create a tabset pane
#             tabsetPanel(
#               # Create a tab panel
#               tabPanel("Small Multiples",
#                        plotOutput("Small Multiples", width = "100%", height = "100%")
#               )  # tabPanel  
#             )  # tabsetPanel
#           )  # mainPanel
#           
#         )  # sidebarLayout
#       ),  # tabPanel
# 
# #### Parallel Coordinates Plot ####            
#     # Create a tab panel
#     tabPanel("Parallel Coordinates Plot",
#       # Layout a sidebar and main area
#       sidebarLayout(
#         # Create a sidebar panel
#         sidebarPanel(
#           wellPanel(
#             # Checkbox Group Input Control
#             checkboxGroupInput("variables2", "Choose variables:", 
#                                c("Population",
#                                  "Income",
#                                  "Illiteracy",
#                                  "Life.Exp",
#                                  "Murder",
#                                  "HS.Grad",
#                                  "Frost",
#                                  "Area",
#                                  "Pop.Density")
#                                , selected = c("Population", "Income")
#             )  # checkboxGroupInput
#           ),  # wellPanel
#           
#           # Create a well panel
#           wellPanel(
#             # Create a select list input control
#             selectInput("scaling", "Scaling:",
#                         c("std", "robust", "uniminmax", "globalminmax", "center", "centerObs"),
#                         selected="uniminmax"
#             )  # selectInput
#           ),  # wellPane
#           
#           # Create a well panel
#           wellPanel(
#             # Create a select list input control
#             selectInput("colorScheme","Color Scheme:",
#             c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2"),
#             selected='Set1'
#             ),  # selectInput
#                      
#           # Add a little bit of space between widgets
#           br(),
#            
#           # Create radio buttons.
#           radioButtons("colorBy2", "Color by:",
#                         c("Region", "Division"),
#                         selected = "Region"
#           ),  # radioButtons
#            
#           # Add a little bit of space between widgets
#           br(),
#           
#             # Slider Input Widget
#             sliderInput("opacity", "Opacity:", 0.1, 1.0, 0.8, step=0.1
#             )  # sliderInput
#           )  # wellPanel                     
#           
#         ),  # sidebarPanel
#         
#         # Create a main panel
#         mainPanel(
#           # Create an plot output element
#           plotOutput("PCP", width = "100%", height = "100%"
#           )  # plotOutput
#         )  # mainPanel
#         
#       )  # sidebarLayout
#     )  # tabPanel of "Parallel Coordinates Plot"
   
             
#### ending ####             
  )  # navbarPage
)  # shinyUI
