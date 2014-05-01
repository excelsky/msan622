shinyServer(function(input, output) {
    output$bubblePlot <- renderPlot({
        print(bubblebubble(input$x, input$y, input$sizeBy, "continents", input$abbrev))
    })
    
#     output$densityPlot <- renderPlot({
#         print(densitydensity(input$x))
#     })
})
