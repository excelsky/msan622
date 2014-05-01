shinyServer(function(input, output) {
    output$mainPlot <- renderPlot({
        print(bubble(input$x, input$y, input$sizeBy, input$colorBy, input$abbrev))
    })
    
#     output$overviewPlot <- renderPlot({
#         print(plotOverview(input$start, input$num, input$LPvar))
#     })
})
