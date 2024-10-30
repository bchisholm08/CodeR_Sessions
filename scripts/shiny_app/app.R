library(shiny)
library(ggplot2)
library(dplyr)

# Define UI for your app
ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")  # Link to custom CSS
  ),
  titlePanel("CodeR Sessions - Practice R with Real Data"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", choices = c("mtcars", "iris")),
      actionButton("load", "Load Dataset"),
      hr(),
      uiOutput("var_select"),
      sliderInput("obs", "Number of observations to view:", min = 5, max = 50, value = 10)
    ),
    mainPanel(
      tableOutput("data"),
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  datasetInput <- eventReactive(input$load, {
    switch(input$dataset,
           "mtcars" = mtcars,
           "iris" = iris)
  })

  output$data <- renderTable({
    head(datasetInput(), input$obs)
  })

  output$var_select <- renderUI({
    dataset <- datasetInput()
    if (!is.null(dataset)) {
      selectInput("var", "Variable to plot:", choices = names(dataset))
    }
  })

  output$plot <- renderPlot({
    req(input$var)
    dataset <- datasetInput()
    ggplot(dataset, aes_string(x = input$var)) +
      geom_histogram(fill = "#007bff", color = "white", bins = 10) +
      theme_minimal() +
      labs(title = paste("Distribution of", input$var))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
