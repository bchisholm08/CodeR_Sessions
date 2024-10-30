library(httr)
library(jsonlite)

# Function to generate research questions based on dataset
generate_research_questions <- function(dataset_metadata) {
  # Define the API endpoint and API key
  api_url <- "https://api.openai.com/v1/completions"
  api_key <- Sys.getenv("OPENAI_API_KEY")  # Set your OpenAI API key as an environment variable
  
  # Prepare the prompt using the dataset metadata
  prompt <- paste0(
    "Given the following dataset columns: ", paste(dataset_metadata, collapse = ", "), 
    ", generate two statistical research questions."
  )
  
  # Set up the request body
  body <- list(
    model = "text-davinci-003", # other opts? 
    prompt = prompt,
    max_tokens = 150, 
    n = 2, # num expected responses? 
    temperature = 0.7 # google this 
  )
  
  # Make the POST request to the OpenAI API
  response <- POST(
    url = api_url,
    add_headers(Authorization = paste("Bearer", api_key)),
    body = toJSON(body, auto_unbox = TRUE),
    encode = "json"
  )
  
  # Check the response status
  if (http_status(response)$category != "Success") {
    stop("Failed to generate questions: ", content(response, "text"))
  }
  
  # Parse the response and extract the generated questions
  response_content <- content(response, as = "parsed", type = "application/json")
  questions <- sapply(response_content$choices, function(choice) choice$text)
  
  return(questions)
} # function end 

# Example
# dataset_metadata <- c("player", "yards_per_carry", "team", "attempts")
# questions <- generate_research_questions(dataset_metadata)
# print(questions)
