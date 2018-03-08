# Load libraries

# install.packages("maps")
# install.packages("sp")
# install.packages("maptools")
# install.packages('rsconnect')
# install.packages('tidyr')
# install.packages('scales')

library(scales)
library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)
library(maps)

#Set working directory to source location and read in data file

my.data <- read.csv('outbreaks.csv', stringsAsFactors=FALSE, na.strings = c("", "NA"))

# Create a server for app

#Gloriane
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
        labs(title= (paste("Top Contaminated Food In", input$yearinput)), y = "Recorded Occurences") +
        guides(fill = FALSE)
   } else {
      
      p <- ggplot(data = table.list) +
        geom_bar(mapping = aes(x = Location, y = n, fill = Location), stat = "identity") +
        coord_flip() +
        labs(title = paste("Number of Recorded Location with Contamination In", input$yearinput), y = "Recorded Occurences") +
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
  text <-paste0("In ", input$yearinput[1], ", ", table$Food[table$n == max(table$n)], " was recorded most commonly with a number of ",
               table$n[table$n == max(table$n)], " records")
  } else {
    text <-paste0("In ", input$yearinput[1], ", the ", table$Location[table$n == max(table$n)], " was recorded most commonly with a number of ",
                 table$n[table$n == max(table$n)], " records")
  
  }
})

  output$glo.head1 <- renderText({
    return("What food has the most risk of being contaminated in what location?")
  })
  
  output$glo.analysis <- renderText({
    return("Chicken is the trending top food and ingredient that has been recorded for contamination (Other than fish in 2003).
            Food contamination has been most commonly occurring when prepared at restaurants. Since 1998,
            the number of occurrences at restaurants has greatly decreased,
            showing that food hygiene and safety are improving thanks to stricter implementation of laws and regulations.
            We can thank the Food Safety and Inspection Service by the United States Department of Agriculture for the improvement in 
food diseases outbreaks. However, Chicken has been consitently rising as a cause of foodborne diseases and must be monitored.")
  })
  
  output$glo.anaylsis2 <- renderText({ 
    return("Click here for more reference about Food Safety and Inspection Service")
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Rahul
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  View(group_by(my.data, Year) %>%
         mutate(sum = sum(Illnesses)))
  
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
    switch(input$emma.type,
           "Illnesses" = illnesses, "Hospitalizations" = hospitalization)
  })
  
  state <- map_data("state")
  
  output$map <- renderPlot({
    map.data <- typeInput() %>%
      left_join(state, by = c("State" = "region"))
    
    data.year <- map.data %>%
      select(num_range('', input$emma.year[1]:input$emma.year[2]))
    
    map.data <- mutate(map.data, mean = rowMeans(data.year, na.rm = TRUE))
    
    p <- ggplot(data = map.data) +
      geom_polygon(aes(x = long, y = lat, group = group, fill = mean)) + 
      scale_fill_continuous(low = 'thistle2', high = 'darkred', guide = 'colorbar') + 
      labs(title = paste0("Foodborne Diseases From ", input$emma.year[1], " to ", input$emma.year[2]), 
           x = "Longitude",
           y = "Latitude",
           fill = paste0("Number of ", input$emma.type[1])) +
      theme(text = element_text(size = 16)) +
      coord_quickmap()
    
    return(p)
  })
  
  
  ill.trend <- my.data %>%
    group_by(Year) %>%
    summarize('num' = sum(Illnesses, na.rm = TRUE))
  
  hosp.trend <- my.data %>%
    group_by(Year) %>%
    summarize('num' = sum(Hospitalizations, na.rm = TRUE))
  
  trendInput <- reactive({
    switch(input$emma.type,
           "Illnesses" = ill.trend, "Hospitalizations" = hosp.trend)
  })
  
  output$trend <- renderPlot({
    data.year <- trendInput() %>%
      filter(Year == c(input$emma.year[1]:input$emma.year[2]))
    
    p <- ggplot(data = data.year) + 
      geom_bar(stat = "identity", aes(x = Year, y = num), fill = 'darkgrey') + 
      labs(title = paste0(input$emma.type[1], " From ", input$emma.year[1], " to ", input$emma.year[2]), 
           x = "Year",
           y = paste0("Number of ", input$emma.type[1])) + 
      theme_minimal() +
      theme(text = element_text(size = 16))
    return(p)
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Daniel
  
  Mode <- function(x) {
    ux <- unique(x)
    ux[which.max(tabulate(match(x, ux)))]
  }
  
  filtered <- reactive({
    sum.month <-  filter(my.data, Year == input$daniel.year) %>%
                  group_by(Species) %>%
                  mutate(Count = sum(Illnesses)) %>%
                  arrange(-Count) %>%
                  subset(!is.na(Species))
    sum.month <- filter(sum.month, Species == sum.month$Species[1]) %>%
                 group_by(Month) %>%
                 mutate(Mode = Mode(Location), Sum = sum(Illnesses)) %>%
                 distinct(Month, .keep_all = TRUE)
    View(sum.month)
    return(sum.month)
  })
  
  table <- reactive({
    ten <-  filter(my.data, Year == input$daniel.year) %>%
                  group_by(Species) %>%
                  mutate(Count = sum(Illnesses)) %>%
                  arrange(-Count) %>%
                  subset(!is.na(Species)) %>%
                  distinct(Species, .keep_all = TRUE)
  })
  
  
  output$plot <- renderPlot({
    graph <- ggplot(data = filtered(), aes(Month, Sum)) +
             geom_bar(stat = "identity", aes(fill = Month)) + 
             scale_fill_brewer(palette = "Paired", na.value = "Black") +
              geom_text(aes(label = Sum), vjust=-0.3, size = 5) +
              xlab("Month") +
              ylab("Count of Recorded Illness") +
              ggtitle(paste(" Worst Disease in", input$daniel.year, "-", filtered()$Species[1])) + 
              theme_minimal() + 
              guides(fill=FALSE) +
              theme(text = element_text(size = 16), axis.text.x = element_text(size=12))
    return(graph)
  })
  
  output$plot2 <- renderPlot({
    if (input$sort == "10 Most Recorded Diseases") {
      table <- head(table(), 10)
    } else if (input$sort == "All") {
      table <- head(table(), 10)
    } else {
      table <- tail(table(), 10)
    }
    graph <- ggplot(data = table, aes(Species, Count)) +
              geom_bar(stat = "identity", aes(fill = Month), position = "stack") + 
              scale_fill_brewer(palette = "Paired", na.value = "Black") +
              ggtitle(paste(input$sort, "in", input$daniel.year)) + 
              theme_minimal() + 
              guides(fill=FALSE) +
              scale_x_discrete(labels = abbreviate) +
              xlab(NULL) + ylab(NULL) +
              theme(text = element_text(size = 16), axis.text.x = element_text(size=12)) +
              coord_flip()
    return(graph)
  })
  
  output$message <- renderText({
    return(paste0("This bar graph is organized by year. Right now, the graph displays information from ", input$daniel.year, ". 
            The graph shows the disease that had the most recorded illnesses in ", input$daniel.year, ". The bar graph is organized 
            by month for users to see any relationships between the time of year and the illness' frequency."))
  })
  
  output$message2 <- renderText({
    return("You can interact with the bar graph by hovering over each bar. 
            A gray area labeled 'Extra Information' will show up above, where you will be able to
            see more information about the disease, organized by month. You can see how many 
            records of the illness for that month and the most recorded location of the disease
            (e.g. whether people got the disease at a restaurant the most vs. at home)." 
            )
  })
  
  output$message3 <- renderText({
    return("Since this database is quite large, it is hard to display all the different types of 
          diseases for users to view. However, to streamline the important information, you can interact with 
          a table by clicking on the 'Table' Tab above. This table will show the Top 10 recorded diseases, 
           the bottom 10 diseases, and all of the diseases, changeable through the side panel. ")
  })
  
  output$note <- renderText({
    return("Note: This chart is to help viewers visualize the differences and similarities of foodborne diseases over 
           the years. However, it is limited to the 10 Most Recorded Diseases and the 10 Least Recorded Diseases. 
           The table below can show ALL recorded diseases. The labels are abbreviated because some are very long. From the dataset, there were some records of multiple
            diseases (for multiple states, cases) and that has affected this visualization. The bar graph corresponds with the information from the table though,
           so viewers should be able to connect the abbreviations to the diseases.")
  })
  
  output$header <- renderText({
    return("Analyzing the Most Common Foodborne Disease")
  })
  
  output$header1 <- renderText({
    return(paste("Viewing", input$sort))
  })
  
  output$head <- renderText({
    return("How to Read This Bar Graph")
  })
  
  output$head2 <- renderText({
    return("Interact with this Bar Graph")
  })
  
  output$head3 <- renderText({
    return("More Information")
  })
  
  output$head4 <- renderText({
    return("Data Analysis - What Can We Take Away")
  })
  
  output$head5 <- renderText({
    return("What are the most common foodborne diseases? Is there a theme over time with the worst foodborne diseases?")
  })
  
  output$message4 <- renderText({
    return("The question we wanted to answer in this section was" )
  })
  

  output$table <- renderDataTable({
    if (input$sort == "10 Most Recorded Diseases") {
      table <- head(table(), 10)
    } else if (input$sort == "10 Least Recorded Diseases") {
      table <- tail(table(), 10)
    } else {
      table <- (table())
    }
    return(select(table, Species, Count))
  })
}

# Connects server to app

shinyServer(my.server)
