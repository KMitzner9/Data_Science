#################################
#  CREATING A SHINY APP WITH R  # 
#################################
install.packages("rtools40")
if (!require("remotes"))
  install.packages("remotes")
remotes::install_github("rstudio/shiny")
install.packages("shiny")
library(shiny)

#create the UI
ui <- fluidPage("Hello World!")

#create a server
server <- function(input, output) {}

#create the shiny app
shinyApp(ui = ui,
         server = server)

#create shiny app that takes input and returns output
ui <- fluidPage(
  titlePanel("input and output"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "num",
        label = "Choose a Number",
        min = 0,
        max = 100,
        value = 25)),
    mainPanel(
      textOutput(
        outputId = "text"
      )
    )
  )
)

#server function that maps input to output
server <- function(input, output) {
  output$text <- renderText({
    paste("You selected: ", input$num)
  })
}

shinyApp(ui = ui,
         server = server)

#create a shiny app with the decision tree model we created earlier
load("Tree.RData")
library(RColorBrewer)
library(tree)
library(shiny)

#create color palette
palette <- brewer.pal(3, "Set2")

#create UI
ui <- fluidPage(
  titlePanel("Iris Species Predictor"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "petal.length",
        label = "Petal Length (cm)",
        min = 1,
        max = 7,
        value = 4),
      sliderInput(
        inputId = "petal.width",
        label = "Petal Width (cm)",
        min = 0.0,
        max = 2.5,
        step = 0.5,
        value = 1.5)),
    mainPanel(
      textOutput(outputId = "text"),
      plotOutput(outputId = "plot"))))

#create server code
server <- function(input, output) {
  output$text = renderText({
    
    #create predictors
    predictors <- data.frame(
      Petal.Length = input$petal.length,
      Petal.Width = input$petal.width,
      Sepal.Length = 0,
      Sepal.Width = 0)
    
    #make prediction
    prediction = predict(
      object = model, 
      newdata = predictors,
      type = "class")
    
    #create prediction text
    paste("The predicted species is ", as.character(prediction))
    
  })
  output$plot = renderPlot({
    
    #create scatter plot
    plot(
      x = iris$Petal.Length,
      y = iris$Petal.Width,
      pch = 19,
      col = palette[as.numeric(iris$Species)],
      main = "Iris Petal Length vs Width",
      xlab = "Petal Length",
      ylab = "Petal Width")
    #plot decision tree boundaries
    partition.tree(model,
                   label = "Species",
                   add = TRUE)
    #Draw predictor on plot
    points(
      x = input$petal.length,
      y = input$petal.width,
      col = "red",
      pch = 4,
      cex = 2,
      lwd = 2)
  })
}

shinyApp(ui = ui,
         server = server)
#this works on the other page bc of the variables created ;)