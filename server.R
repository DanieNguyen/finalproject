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
    data.set <- data.set %>%
      filter(Year == input$yearinput ) # CHANGE "YEAR" 
    return(data.set)
  })
  
  getDataTable <- reactive({
    if(input$radio ==  "Food") {
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
      return(food.list)
    } else {
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
      return(location.list)
    }
  })
  
  output$food.plot <- renderPlot({
    table.list <- getDataTable()
    p <- ""
    if(input$radio == "Food") {
  
      p <- ggplot(data = table.list) +
         geom_bar(mapping = aes(x = Food, y = n, fill = Food), stat = "identity") +
        labs(title= (paste("Top contaminated food in", input$year)), y = "Recorded Occurences") +
        guides(fill = FALSE)
   } else {
      
      p <- ggplot(data = table.list) +
        geom_bar(mapping = aes(x = Location, y = n, fill = Location), stat = "identity") +
        coord_flip() +
        labs(title = paste("Number of Recorded Location with Contamination in", input$year), y = "Recorded Occurences") +
        guides(fill = FALSE)
    }
    return(p)
  })
  
  output$food.table <- renderTable({
      table.list <- getDataTable()
      colnames(table.list)[2] <- "# Recorded"
      return(table.list)
  })
  
  output$analysis <- renderText({
    table <- getDataTable()
    if (input$radio == "Food") {
      text <-paste("Displayed are the top 10 types of different foods that were recorded for food contamination from 1998 to 2015.")
    } else {
      text <-paste("Displayed are all the recorded locations that were reported due to food contamination from 1998 to 2015.")
    }
  })
  

  output$analysis2 <- renderText({
    table <- getDataTable()
  if (input$radio == "Food") {
  text <-paste("In", input$year[1], ",", table$Food[table$n == max(table$n)], "was recorded most commonly with a number of",
               table$n[table$n == max(table$n)], "records")
  } else {
    text <-paste("In", input$year[1], ", The", table$Location[table$n == max(table$n)], "was recorded most commonly with a number of",
                 table$n[table$n == max(table$n)], "records")
  
  }
})

  output$glo.head1 <- renderText({
    return("What food has the most risk of being contaminated in what location?")
  })
  
  output$glo.analysis <- renderText({
    return("Chicken is the trending top food and ingredient that has been recorded for contaminiation (Other than fish in 2003).
            Food contamination has been most commonly occuring when prepared at restaurants. Since 1998,
            the number of occurences at restaurants has greatly decreased,
            showing that food hygeine and safety are improving thanks to some implemntation of laws and regulations 
            thanks to the, Food Safety and Inspection Service by the  United States Department of Agriculture. However the cause of food poisoning continues 
           to consistently rise with Chicken.")
  })
  
  output$glo.anaylsis2 <- renderText({ 
    return("Click here for more reference about Food Safty and Inspection Service")
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Rahul
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Emma
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Daniel
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  



# Connects server to app
}

shinyServer(my.server)