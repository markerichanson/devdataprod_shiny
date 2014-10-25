t<-seq_along(mtcars)
names(t)<-names(mtcars)
shinyUI(
  fluidPage(
    # Application title
    titlePanel("Exploring Relationships Between mtcars Variables"),
    sidebarPanel(
      h2('Instructions'),
      div(HTML(
        "Use this page to explore linear relationships between pairs of variables in the mtcars dataset.
        Select a variable to use as the X axis and a variable for the Y axis.  Click the submit button and the selected variables will render to the right.
        Optionally, check the check box to see details of the lm fit of the selected variables."
        )),
      h2('Controls:'),
      selectInput (
          "xAxis",
          "Select variable for X Axis",
          selected=t[11],
          t
        ),
      
      selectInput(
          "yAxis", 
          "Select variable for Y Axis",
          selected=t[1],
          t
         ),
      checkboxInput (
        "includeRegression",
        "Include Linear Regression?",
        FALSE
      ),
      submitButton('Submit')
    ),
    mainPanel(
      h2('Here is your visualization'),
      plotOutput("plot"),
      conditionalPanel(
        condition = "input.includeRegression == 1",
        h2('Details of the linear regression'),
        tableOutput("fitTable")
      )
    )
  )
)