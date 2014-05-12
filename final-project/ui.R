shinyUI(
  fluidPage(
    pageWithSidebar(
      headerPanel("World Census 1994"),
      sidebarPanel(
        width = 3,
        selectInput("x", "X axis",
                    c("Mean Age",
                      "Mean Education Years",
                      "Mean Capital Gain",
                      "Mean Capital Loss",
                      "Mean Hours per Week"),
                    selected = "Mean Education Years"
        ),  # selectInput
        
        selectInput("y", "Y axis",
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
      ), # sidebarPanel
      
      mainPanel(
        width = 9,
        tabsetPanel(
          tabPanel("Bubble Plot", plotOutput("bubblePlot", height="400px")),
          tabPanel("Heat Map", plotOutput("heatMap", height="500px")),
          tabPanel("Density Plot", plotOutput("densityPlot", height="400px")),
          tabPanel("Bar Plot", plotOutput("barPlot", height="400px"))
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