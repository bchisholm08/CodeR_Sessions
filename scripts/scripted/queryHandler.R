library(DBI)

# Function to add a new query
add_new_query <- function(title, category, pdf_path) {
  # Database connection
  con <- dbConnect(RSQLite::SQLite(), "/srv/shiny-server/queries_metadata.db")
  
  # Generate a new query number
  # generate this number randomly or sequentially 
  query_number <- as.numeric(dbGetQuery(con, "SELECT MAX(query_number) FROM queries")[[1]]) + 1
  
  # Define file name and store the PDF in the right directory
  new_file_name <- paste0(gsub(" ", "_", tolower(title)), "_", query_number, ".pdf")
  target_directory <- file.path("/srv/shiny-server/queries", category)
  new_file_path <- file.path(target_directory, new_file_name)
  file.copy(pdf_path, new_file_path)
  
  # Insert metadata into the database
  dbExecute(con, "INSERT INTO queries (query_number, title, category, file_path, tags) VALUES (?, ?, ?, ?, ?)",
            params = list(query_number, title, category, new_file_path, toString(c("tag1", "tag2"))))
  
  # Disconnect from the database
  dbDisconnect(con)
}

# Example usage
add_new_query("NFL Rushing Analysis", "sports", "/path/to/local/nfl_rushing_temp.pdf")
