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
library(stringr)

#Set working directory to source location and read in data file

my.data <- read.csv('outbreaks.csv', stringsAsFactors=FALSE)

# Create a server for app

my.server <- function(input, output) {
  # Gloriane
  
  filter.food <- reactive({# Most mentioned Ingredients #Most mentioned species/Illness # Is it differnt each year?
    data.set <- my.data["state" != "Multistate"]
    data.set <- na.omit(data.set)
    data.set <- data.set %>%
      select(Year, Ingredient, Food, Species, State) %>%
      filter(Year == 1998) # CHANGE "YEAR" 
    
    # Distinct specific ingridients in that YEAR
    list.of.ingredients <- distinct(data.set, Ingredient)
    list.of.species <- distinct(data.set, Species)
    
    # Cleaning up names preparing for manipulation
    food.list <- data.frame("Food" = unlist(strsplit(data.set$Food, ";")), stringsAsFactors = FALSE)
    food.list <- data.frame("Food" = unlist(strsplit(food.list$Food, ",")), stringsAsFactors = FALSE)
    food.list <- as.data.frame(lapply(food.list, trimws), stringsAsFactors = FALSE)
    
    food.list <- food.list %>%
      count(Food, sort = TRUE) %>%
      filter(Food != "Unspecified" & Food != "Other") %>%
      group_by(Food) %>%
      arrange(desc(n))
    return(food.list)
  })
  
  filter.location <- reactive({

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