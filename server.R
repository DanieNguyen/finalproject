# Load libraries
# install.packages("maps")
# install.packages("sp")
# install.packages("maptools")
# install.packages('rsconnect')
library(shiny)
library(dplyr)
library(maps)
library(ggplot2)
library(tidyr)

#Set working directory to source location and read in data file

my.data <- read.csv('outbreaks.csv', stringsAsFactors=FALSE)

# Create a server for app

my.server <- function(input, output) {
  # Gloriane
  filter <- reactive({# Most mentioned Ingredients #Most mentioned species/Illness # Is it differnt each year?
    data.set <- my.data %>%
    
    # Distinct specific ingridients
    # Splices ingridient seperately and then take the n count of each ingridients
    list.of.ingredients <- distinct(my.data, Ingredient)
    list.of.species <- distinct(my.data, Species)
    
    split.igre.list <- data.frame("Ingredient" = unlist(strsplit(list.of.ingredients[1:nrow(list.of.ingredients), ], ";")), stringsAsFactors = FALSE)
    split.igre.list <- split.list %>%
      count(Ingredient, sort = TRUE)
    
    split.spec.list <- data.frame("Species") = unlist(strsplit(list.of.species[1:nrow(list.of.species), ], ";"))
    
    ingredients.data <- my.data %>%
      select(Ingredient) %>%
      group_by(Ingredient) %>%
      summarize("Count" = Ingrin_distinct(Ingredient))
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Rahul
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Emma
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Daniel
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  output$text <- renderText({
    return("HI")
  })
}

# Connects server to app

shinyServer(my.server)