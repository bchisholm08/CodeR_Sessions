---
title: "scrape_datasets.Rmd"
author: "Brady M. Chisholm"
date: "2024-10-30"
output: html_document
---

# Load required packages
library(rvest)
library(tidyverse)
library(httr)

# Function to scrape datasets from open data websites
scrape_dataset <- function(url, css_selector, output_path) {
  tryCatch({
    # Get the HTML content of the page
    page <- read_html(url)
    
    # Extract the dataset link using the provided CSS selector
    dataset_link <- page %>%
      html_nodes(css_selector) %>%
      html_attr('href') %>%
      .[1] # Assume the first link is the dataset, can be adjusted
    
    # Construct the full link if the link is relative
    if (startsWith(dataset_link, "/")) {
      dataset_link <- paste0(url, dataset_link)
    }
    
    # Download the dataset
    GET(dataset_link, write_disk(output_path, overwrite = TRUE))
    
    message("Dataset successfully scraped and saved at: ", output_path)
  }, error = function(e) {
    message("Failed to scrape the dataset: ", e$message)
  })
}

# Example usage
# Define the URL of the open data page
url <- "https://example.com/datasets"

# Define the CSS selector for the dataset link
css_selector <- ".dataset-download-link"

# Define where to save the dataset
output_path <- "data/scraped_dataset.csv"

# Run the scraping function
scrape_dataset(url, css_selector, output_path)

# Function to create an interactive R coding exercise using learnr
library(learnr)

create_learnr_tutorial <- function(dataset_path) {
  tutorial <- learnr::tutorial(
    title = "Practice R with Real-World Data",
    author = "Brady M. Chisholm",
    learnr::chapter(
      "Introduction",
      learnr::text("Welcome to this interactive R exercise! In this tutorial, you'll work with a dataset that was recently scraped from an open-source website."),
      learnr::text("Let's get started by loading the dataset."),
      learnr::exercise(
        "Load the dataset",
        "# Use read.csv to load the dataset
        data <- read.csv('<dataset_path>')",
        "data"
      )
    ),
    learnr::chapter(
      "Data Exploration",
      learnr::exercise(
        "View the first few rows",
        "# Use head() to explore the dataset
        head(data)",
        "head(data)"
      ),
      learnr::exercise(
        "Summary of the dataset",
        "# Use summary() to get a quick overview of the dataset
        summary(data)",
        "summary(data)"
      )
    )
  )
  return(tutorial)
}

# Example usage
# Create a learnr tutorial with the scraped dataset
learnr_tutorial <- create_learnr_tutorial(output_path)

# Run the tutorial (uncomment this line to test it)
# learnr::run_tutorial(learnr_tutorial)



