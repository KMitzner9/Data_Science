library(shiny)

# Define UI ----
ui <- fluidPage(
  titlePanel("censusVis"),
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with information from the 2010 US Census."),
      selectInput("var",
                label = "Choose a variable to display",
                choices = list("Percent White", "Percent Black",
                                "Percent Hispanic", "Percent Asian"),
                selected = "Percent Black"),
      sliderInput("range", strong("Range of interest:"),
                min = 0, max = 100, value = c(0, 100))),
    mainPanel()
  )
)

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server)