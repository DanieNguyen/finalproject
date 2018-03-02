# Load libraries
# install.packages("maps")
# install.packages("sp")
# install.packages("maptools")
# install.packages('rsconnect')
library(shiny)
library(dplyr)
library(maps)
library(ggplot2)

#Set working directory to source location and read in data file

my.data <- read.csv('outbreaks.csv', stringsAsFactors=FALSE)
View(my.data)

# Create a server for app

my.server <- function(input, output) {
  # Glorianne
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Rahul
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Emma
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Daniel
  filtered <- reactive({
    sum.state <- group_by(my.data, State) %>%
      filter(Month == input$month) %>%
      mutate(Count = sum(Illnesses)) %>%
      distinct(Year, .keep_all = TRUE) %>%
      filter(Year == input$year) %>%
      select(State, Count)
    colnames(sum.state) <- c("State", "Record of Illnesses")
    return(sum.state)
  })
  
  
  
  
  
  
  
  
  
  
  
  output$message <- renderText({
    return("hello")
  })
  
  output$table <- renderDataTable({
    return(filtered())
  })
}

# Connects server to app

shinyServer(my.server)