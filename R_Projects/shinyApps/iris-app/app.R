library(shiny)
iris <- read.csv("data/Iris.csv")
source("helpers.R")

# Define UI ----
ui <- fluidPage(
  titlePanel("Iris Data Visualization with R"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create scatter plots with the Iris data set."),
      img(src = "iris3.png", height = 200, width = 200),
      radioButtons("species", h3("Choose Species:"),
                   choices = list("Setosa", "Versicolor",
                                  "Virginica"),selected = "Setosa"),
      radioButtons("feature", h3("Choose Comparison"),
                 choices = list("Petal Length vs. Width", 
                                "Sepal Length vs. Width")),
      br(),
      checkboxInput("lin_reg", "Draw Linear Regression Line", value = FALSE)),
      
    mainPanel(
      textOutput("selected_species"),
      textOutput("selected_comparison"),
      plotOutput("scatter_plot")
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$selected_species <- renderText({
    paste("Species: ", input$species)
  })
  output$selected_comparison <- renderText({
    paste(input$feature)
  })
  output$scatter_plot <- renderPlot({
    species <- switch(input$species,
                   "Setosa" = setosa,
                   "Versicolor" = versicolor,
                   "virginica" = virginica)
    feature <- switch(input$feature,
                      "Petal Length vs. Width" = c(Petal.Length, Petal.Width),
                      "Sepal Length vs. Width" = c(Sepal.Length, Sepal.Width))
    xlab <- feature[1]
    ylab <- feature[2]
    plot(
      x = species$feature[1],
      y = species$feature[2],
      xlab = xlab,
      ylab = ylab)
  })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)