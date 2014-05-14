shinyServer(function(input, output) {
  cat("Press \"ESC\" to exit...\n")
  
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
  
  output$bubblePlot <- renderPlot({
    print(bubblebubble(input$x1, input$y1, input$sizeBy, input$abbrev,
                       input$aCoun, input$eCoun, input$naCoun, input$saCoun,
                       filter_color()))
  })
  
  output$heatMap <- renderPlot({
    print(heatheat(input$x2, input$midrange))
  })
  
  output$densityPlot <- renderPlot({
      print(densitydensity(input$x3))
  })
  
  output$barPlot <- renderPlot({
    print(barbar(input$y4, input$ratio))
  })
  
})
