library(dplyr)
library(tidyr)

clean_data <- function(input_path, output_path) {
  data <- read.csv(input_path)
  cleaned_data <- data %>%
    filter(!is.na(variable)) %>%
    mutate(new_variable = as.factor(old_variable))
  write.csv(cleaned_data, output_path, row.names = FALSE)
  message("Data cleaned and saved at: ", output_path)
}