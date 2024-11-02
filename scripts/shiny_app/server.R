library(shiny)
library(ggplot2)
library(dplyr)

server <- function(input, output) {
  
  # Data Exploration Logic
  # this code definitely needs to change 
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
    cleanMyData(input$file1$datapath, output_path)
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