shinyUI(
  fluidPage(
    pageWithSidebar(
      headerPanel("World Census 1994"),
      sidebarPanel(
        width = 3,
        conditionalPanel(condition="input.conditionedPanels==1",
          selectInput("x1", "X axis",
                      c("Mean Age",
                        "Mean Education Years",
                        "Mean Capital Gain",
                        "Mean Capital Loss",
                        "Mean Hours per Week"),
                      selected = "Mean Education Years"
          ),  # selectInput
          
          selectInput("y1", "Y axis",
                      c("Mean Age",
                        "Mean Education Years",
                        "Mean Capital Gain",
                        "Mean Capital Loss",
                        "Mean Hours per Week"),
                      selected = "Mean Hours per Week"
          ),  # selectInput
          br(),
          
          selectInput("sizeBy", "Bubble Size",
                      c("Mean Age",
                        "Mean Education Years",
                        "Mean Capital Gain",
                        "Mean Capital Loss",
                        "Mean Hours per Week"),
                      selected = "Mean Age)"
          ),  # selectInput
          
          checkboxInput("abbrev","Country Name", value=TRUE
          ),  # checkboxInput
          
          br(),
          
          selectInput("colScheme", "Color Scheme",
                      c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2")
          ) # selectInput
        ), # conditionalPanel for Bubble Plot
        
        conditionalPanel(condition="input.conditionedPanels==2",
          selectInput("x2", "X axis  (Thank you for being patient.)",
                      c("Highest Degree in Education",
                        "Occupation",
                        "Work Class"),
                      selected = "Occupation"
          )  # selectInput
        ), # conditionalPanel for Heat Map
        
        conditionalPanel(condition="input.conditionedPanels==3",
          selectInput("x3", "X axis",
                      c("Age",
                        "Years of Education"),
                      selected = "Years of Education"
          )  # selectInput
        ), # conditionalPanel for Density Plot
        
        conditionalPanel(condition="input.conditionedPanels==4",
          selectInput("y4", "Y axis",
                      c("Highest Degree in Education",
                        "Marital Status",
                        "Occupation",
                        "Race",
                        "Relationship",
                        "Sex",
                        "Work Class"),
                      selected = "Highest Degree in Education"
          ),  # selectInput
         checkboxInput("ratio","Ratio", value=F
         )  # checkboxInput
        ) # conditionalPanel for Bar Plot
      ), # sidebarPanel
      
      mainPanel(
        width = 9,
        tabsetPanel(
          tabPanel("Bubble Plot", value=1, plotOutput("bubblePlot", height="400px")),
          tabPanel("Heat Map", value=2, plotOutput("heatMap", height="500px")),
          tabPanel("Density Plot", value=3, plotOutput("densityPlot", height="400px")),
          tabPanel("Bar Plot", value=4, plotOutput("barPlot", height="400px")),
          id = "conditionedPanels"
        ) # tabsetPanel
      ) # mainPanel
    ), # pageWithSidebar
    
    hr(),
    
    fluidRow(
      column(
        4,
        h4("Instruction"),
        helpText("Please click any buttons to see the interactivity.")
      ), # column of Instruction
      
      column(
        2,
        h4("Asia"),
        selectInput("aCoun", "Asian Countries",
                    c("All", "Cambodia", "China", 
                      "Hong Kong", "India", "Iran", "Japan",            
                      "Laos", "Philippines", "South Korea", "Taiwan",
                      "Thailand", "Vietnam"), multiple=T, selected=c("All")
        ) # selectInput
      ), # column of Asia
      
      column(
        2,
        h4("Europe"),
        selectInput("eCoun", "European Countries",
                    c("All", "England", "France", "Germany", "Greece",
                    "Netherlands", "Hungary", "Ireland", "Italy", 
                    "Poland", "Portugal", "Scotland", "Yugoslavia"),
                    multiple=T, selected = c("All")
        )  # selectInput
      ), # column of Europe
      
      column(
        2,
        h4("North America"),
        selectInput("naCoun", "North American Countries",
                    c("All", "Canada", "Cuba", "Dominican Republic", "El Salvador",
                    "Guatemala", "Haiti", "Honduras", "Jamaica",
                    "Mexico", "Nicaragua", "Puerto Rico", "United States"),
                    multiple=T, selected = c("All")
        )  # selectInput
      ), # column of North America
      
      column(
        2,
        h4("South America"),
        selectInput("saCoun", "South American Countries",
                    c("All", "Columbia", "Ecuador", "Peru", "Trinadad&Tobago"),
                    multiple=T, selected = c("All")
        )  # selectInput
        
#         selectInput("x", "X axis",
#                     c("Age",
#                       "Years of Education",
#                       "Capital Gain",
#                       "Capital Loss",
#                       "Work Hours per Week"),
#                     selected = "Age"
#         ),  # selectInput
#         
#         selectInput("x", "X axis",
#                     c("Work Class",
#                       "Highest Degree in Education",
#                       "Marital Status",
#                       "Occupation",
#                       "Relationship",
#                       "Race",
#                       "Sex",
#                       "Native Country"),
#                     selected = "Highest Degree in Education"
#         ),  # selectInput
        
      ) # column of South America
    ) # fluidRow
  ) # fluidPage
) # shinyUI