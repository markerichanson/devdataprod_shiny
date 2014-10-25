require(ggplot2)
require(xtable)

data(mtcars)

shinyServer(
  function(input, output) {
     
     output$xAxis <- renderPrint(names(mtcars)[[{as.numeric(input$xAxis)}]])
     output$sxAxis <- renderPrint(names(mtcars)[[{as.numeric(input$sxAxis)}]])
     output$yAxis <- renderPrint(names(mtcars)[[as.numeric(input$yAxis)]])
     output$includeRegression <- renderPrint({input$includeRegression})

     output$plot<-renderPlot({
       .e <- environment()
       xIndex <- as.numeric(input$xAxis)
       yIndex <- as.numeric(input$yAxis)
       
       g <- ggplot(
           mtcars,
           environment = .e,
           aes(
             x = mtcars[[xIndex]], 
             y = mtcars[[yIndex]]         
           )
         )
       g <- g + geom_point() 
       # fix the displayed names for the x and y axes
       g <- g+ labs(x = names(mtcars)[xIndex], y = names(mtcars)[yIndex])
       
       if (input$includeRegression) {
         g <- g+ stat_smooth(
           method = "lm", formula = y ~ x, col = "red") 
         smry <- summary(lm(mtcars[[yIndex]]~mtcars[[xIndex]]))$coef
         # fix the named displayed in the renderTable results
         dimnames(smry)[[1]][2]<-names(mtcars)[xIndex]
         
         output$fitTable <- renderTable(smry)
       }
       g
     })
  }
)