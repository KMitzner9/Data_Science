library(shiny)
iris <- read.csv("data/Iris.csv")
head(iris)

# Define UI ----
ui <- fluidPage(
  titlePanel("Iris Data Visualization with R"),
  
  sidebarLayout(
    # Create sidebar with two sets of radio buttons,
    # on for species and one for features to be compared.
    # Also create check box for linear regression line, and
    # picture for aesthetics
    sidebarPanel(
      helpText("Create scatter plots with the Iris data set."),
      img(src = "iris3.png", height = 200, width = 200),
      radioButtons("species", h3("Choose Species:"),
                   choices = list("Setosa",
                                  "Versicolor",
                                  "Virginica"), 
                   selected = "Setosa"),
      radioButtons("feature", h3("Choose Comparison"),
                 choices = list("Petal Length vs. Width", 
                                "Sepal Length vs. Width")),
      br(),
      checkboxInput("lin_reg", "Draw Linear Regression Line", value = FALSE)),
    
    # create main panel with responsive text outputs to be chart titles
    # plot the output of the selected variables
    # display correlation coefficient of that plot
    mainPanel(
      br(),
      textOutput("selected_species"),
      textOutput("selected_comparison"),
      plotOutput("scatter_plot"),
      textOutput("corr")
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  # Displays the choice of Species
  output$selected_species <- renderText({
    paste("Species: ", input$species)
  })
  # Displays the choice of comparison features
  output$selected_comparison <- renderText({
    paste(input$feature)
  })
  #renders the plot, regression line and correlation coefficient
  output$scatter_plot <- renderPlot({
    # Create variables based on inputs
    spec <- switch(input$species,
                   "Setosa" = "setosa",
                   "Versicolor" = "versicolor",
                   "Virginica" = "virginica")
    feature <- switch(input$feature,
                      "Petal Length vs. Width" = c(3, 4),
                      "Sepal Length vs. Width" = c(1, 2))
    # These variables will clean up the following code
    # If there is a cleaner way of doing this, I would love to know!
    X = iris[iris$Species == spec, feature[1]]
    Y = iris[iris$Species == spec, feature[2]]
    xlab <- feature[1]
    ylab <- feature[2]
    
    # Create the scatter plot
    plot(
      x = X,
      y = Y,
      xlab = xlab,
      ylab = ylab)
    
    # Plots a linear regression line if our box is checked
    if (input$lin_reg) {
      model <- lm(Y ~ X)
      lines(
        x = X,
        y = model$fitted,
        col = "red",
        lwd = 3)
    }
    
    # Displays the correlation coefficient
    # Is it bad form to embed a render function in a render function?
    output$corr <- renderText({
      correlation <- cor(X, Y)
      paste("The Correlation Coefficient for these variables is :", correlation)
    })
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)