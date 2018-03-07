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
  
 

    data.set <- my.data["state" != "Multistate"]
    data.set <- na.omit(data.set) %>%
      filter(Food != "" & Location != "")
    
  getYear <- reactive({
    print(input$yearinput)
    print(is.numeric(input$yearinput))
    
    data.set <- data.set %>%
      filter(Year == input$yearinput ) # CHANGE "YEAR" 
    return(data.set)
    
  })
  
  


  
  output$food <- renderPlot({
    
    list.of.ingredients <- getYear() %>%
    select(Year, Food)
    
    # Cleaning up names preparing for manipulation
    food.list <- data.frame("Food" = unlist(strsplit(list.of.ingredients$Food, ";")), stringsAsFactors = FALSE)
    food.list <- data.frame("Food" = unlist(strsplit(food.list$Food, ",")), stringsAsFactors = FALSE)
    food.list <- as.data.frame(lapply(food.list, trimws), stringsAsFactors = FALSE)
    
    food.list <- food.list %>%
      count(Food, sort = TRUE) %>%
      filter(Food != "Unspecified" & Food != "Other") %>%
      group_by(Food) %>%
      arrange(desc(n))
    food.list <- food.list[1:10, ]
    
    p <- ggplot(data = food.list) +
       geom_bar(mapping = aes(x = Food, y = n, fill = Food), stat = "identity") +
      labs(title= (paste("Top contaminated food in", input$year)))
    
    return(p)
  })

  output$location <- renderPlot({
      location.list <- getYear() %>%
        select(Location)
      location.list <- data.frame("Location" = unlist(strsplit(location.list$Location, ";")), stringsAsFactors = FALSE)
      location.list <- as.data.frame(lapply(location.list, trimws), stringsAsFactors = FALSE)
      location.list <- location.list %>%
        filter(Location != "Unknown") %>%
        count(Location, sort = TRUE) %>%
        group_by(Location) %>%
        summarize("n" = sum(n)) %>%
        arrange(desc(n))
      
    p <- ggplot(data = location.list) +
      geom_bar(mapping = aes(x = Location, y = n, fill = Location), stat = "identity") +
      coord_flip() +
      labs(title = paste("Number of recorded contamination based on Location in", input$year))

    return(p)
  })
  
  
  output$text <- renderText({
    return("HI")
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Rahul
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Emma
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Daniel
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  



# Connects server to app
}

shinyServer(my.server)