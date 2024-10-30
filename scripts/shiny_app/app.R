# This script is for the entry point of the shiny app and pulls everything together 
# The heart of the page 

library(shiny)
library(ggplot2)
library(dplyr)

# Define UI for the Shiny app
ui <- navbarPage(
  title = "CodeR Sessions",  # Website title in the navigation bar
  
  # Front Page
  tabPanel(
    title = "Home",  # Front page title
    fluidPage(
      titlePanel("Welcome to CodeR Sessions"),
      p("This website is designed for users to practice R programming with real datasets."),
      p("Explore the pages through the navigation bar above to start practicing!"),
      img(src = "www/welcome_image.jpg", height = "300px"),  # Add an image (make sure it's in the www/ folder)
      hr(),
      p("To get started, click on the 'Explore Data' or 'Clean Data' tabs to dive in.")
    )
  ),
  
  # Data Exploration Page
  tabPanel(
    title = "Explore Data",
    fluidPage(
      titlePanel("Explore Datasets"),
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
  ),
  
  # Data Cleaning Page
  tabPanel(
    title = "Clean Data",
    fluidPage(
      titlePanel("Clean Your Data"),
      fileInput("file1", "Upload CSV File:", accept = ".csv"),
      actionButton("clean", "Clean Data"),
      verbatimTextOutput("clean_summary")
    )
  ),
  
  # Visualization Page
  tabPanel(
    title = "Visualize Data",
    fluidPage(
      titlePanel("Data Visualization"),
      sidebarLayout(
        sidebarPanel(
          fileInput("file2", "Upload Cleaned CSV File:", accept = ".csv"),
          selectInput("plot_var", "Variable to Plot:", choices = NULL)
        ),
        mainPanel(
          plotOutput("custom_plot")
        )
      )
    )
  )
)

# Define server logic for the Shiny app
server <- function(input, output) {
  
  # Data Exploration Logic
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

  # Data Cleaning Logic
  observeEvent(input$clean, {
    req(input$file1)
    data <- read.csv(input$file1$datapath)
    # Assume the `clean_data` function is available from sourced script
    output_path <- tempfile(fileext = ".csv")
    clean_data(input$file1$datapath, output_path)
    cleaned_data <- read.csv(output_path)
    output$clean_summary <- renderPrint({
      summary(cleaned_data)
    })
  })

  # Visualization Logic
  observe({
    req(input$file2)
    data <- read.csv(input$file2$datapath)
    updateSelectInput(session, "plot_var", choices = names(data))
  })

  output$custom_plot <- renderPlot({
    req(input$plot_var, input$file2)
    data <- read.csv(input$file2$datapath)
    visualize_data(data, input$plot_var)
  })
}

# Run the application I don't think I need this line if running locally
# shinyApp(ui = ui, server = server)
