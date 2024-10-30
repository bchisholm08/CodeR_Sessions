# ui.R: Define the User Interface
library(shiny)

ui <- navbarPage(
  title = "CodeR Sessions",  # Website title in the navigation bar
  
  # Front Page
  tabPanel(
    "Home",  # Front page title
    fluidPage(
      titlePanel("Welcome to the CodeR Sessions"),
      p("This website is designed for users to practice R programming with real datasets."),
      p("Explore the pages through the navigation bar above to start practicing!"),
      img(src = "welcomeImg.jpg", height = "300px"),
      hr(), # create a horizontal line 
      p("To get started, click on the 'Explore Data' or 'Clean Data' tabs to dive in.")
    )
  ),
  
 # Explore Queries Page
  tabPanel(
    "Explore Queries",
    fluidPage(
      titlePanel("Explore Generated Queries"),
      selectInput("query_topic", "Filter by Topic:", choices = c("NFL", "Healthcare", "Economics")),
      dataTableOutput("query_table")
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
    title = "Clean Your Data",
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
  )  # end tab panel

  # Community Page
  tabPanel(
    "Community",
    fluidPage(
      titlePanel("Community Contributions"),
      fileInput("user_dataset", "Upload a Dataset", accept = ".csv"),
      textInput("query_title", "Query Title"),
      textAreaInput("query_description", "Query Description"),
      actionButton("create_query", "Create Query")
    )
  ) # end community page 

# solutions page
    tabPanel(
    "Post Solutions",
    fluidPage(
      titlePanel("Submit Your Solutions"),
      selectInput("query_select", "Select a Query to Solve:", choices = NULL),  # Populated from the database
      textAreaInput("solution_code", "Your Solution (R Code):"),
      actionButton("submit_solution", "Submit Solution"),
      hr(),
      h3("Existing Solutions:"),
      dataTableOutput("solution_table")
    )
  ) # end solutions page

) # end ui