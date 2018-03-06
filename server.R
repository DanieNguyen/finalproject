# Load libraries
# install.packages("maps")
# install.packages("sp")
# install.packages("maptools")
# install.packages('rsconnect')
# install.packages('tidyr')
library(shiny)
library(dplyr)
library(maps)
library(ggplot2)
library(tidyr)


#Set working directory to source location and read in data file

my.data <- read.csv('outbreaks.csv', stringsAsFactors=FALSE)

# Create a server for app

my.server <- function(input, output) {
  # Glorianne
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Rahul
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Emma
  my.data$State <- tolower(my.data$State)
  
  illnesses <- my.data %>%
    group_by(Year, State) %>%
    summarize('num' = sum(Illnesses, na.rm = TRUE)) %>%
    spread(key=Year, value=num)
  
  hospitalization <- my.data %>%
    group_by(Year, State) %>%
    summarize('num' = sum(Hospitalizations, na.rm = TRUE)) %>%
    spread(key=Year, value=num)
  
  typeInput <- reactive({
    switch(input$type,
           "Illnesses" = illnesses, "Hospitalization" = hospitalization)
  })
  
  state <- map_data("state")
  
  output$map_plot <- renderPlot({
    map.data <- typeInput() %>%
      left_join(state, by = c("State" = "region"))
    
    data.year <- map.data %>%
      select(num_range('', input$year[1]:input$year[2]))
    
    map.data <- mutate(map.data, mean = rowMeans(data.year, na.rm = TRUE))
    
    p <- ggplot(data = map.data) +
      geom_polygon(aes(x = long, y = lat, group = group, fill = mean)) + 
      scale_fill_continuous(low = 'thistle2', high = 'darkred', guide = 'colorbar') + 
      labs(title = paste0("Foodborne Diseases over years"), 
           x = "Longitude",
           y = "Latitude",
           fill = paste0("Number of ", input$type[1])) +
      coord_quickmap()
    
    return(p)
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Daniel
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  output$text <- renderText({
    return("HI")
  })
}

# Connects server to app

shinyServer(my.server)
