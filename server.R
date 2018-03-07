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
 # getYear <- reactive({

  #  data.set <- my.data["state" != "Multistate"]
   # data.set <- na.omit(data.set) %>%
  #  filter(Year == input$year) # CHANGE "YEAR" 
  #  return(data.set)
    
  #})
  
#  filterFood <- reactive({# Most mentioned Ingredients #Most mentioned species/Illness # Is it differnt each year?
   
 #   data.set <- getYear() %>%
  #    select(Year, Ingredient, Food, Species, State)
    
   # # Distinct specific ingridients in that YEAR
    #list.of.ingredients <- distinct(data.set, Ingredient)
    #list.of.species <- distinct(data.set, Species)
    
    # Cleaning up names preparing for manipulation
    #food.list <- data.frame("Food" = unlist(strsplit(data.set$Food, ";")), stringsAsFactors = FALSE)
    #food.list <- data.frame("Food" = unlist(strsplit(food.list$Food, ",")), stringsAsFactors = FALSE)
  #  food.list <- as.data.frame(lapply(food.list, trimws), stringsAsFactors = FALSE)
    
   # food.list <- food.list %>%
  #    count(Food, sort = TRUE) %>%
  #    filter(Food != "Unspecified" & Food != "Other") %>%
   #   group_by(Food) %>%
  #    arrange(desc(n))
   # return(food.list)
  #})
  
#  filterLocation <- reactive({
 #   data.set <- getYear() %>%
  #  location.list <- data.set  %>% select(Location)
   # location.list <- data.frame("Location" = unlist(strsplit(location.list$Location, ";")), stringsAsFactors = FALSE)
    #location.list <- as.data.frame(lapply(location.list, trimws), stringsAsFactors = FALSE)
    #location.list <- location.list %>%
    #  filter(Location != "Unknown") %>%
    #  count(Location, sort = TRUE) %>%
    #  group_by(Location) %>%
    #  summarize("n" = sum(n)) %>%
    #  arrange(desc(n))
  #  return(location.list)
  #})
  
  #output$food <- renderPlot({
   #  ggplot(data = filterFood()) +
   #     geom_bar(mapping = aes(x = food.list[1:10], y = n[1:10], fill = Location), stat = "count")
  #})

 # output$location <- renderPlot({
 #   ggplot(data = my.data) +
#      geom_point(mapping = aes(x=Year, y = Illnesses))
 # })
  
  
  output$text <- renderText({
    return("HI")
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Rahul
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Emma
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Daniel
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  



# Connects server to app
}

shinyServer(my.server)