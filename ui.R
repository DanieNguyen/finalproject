#install.packages("shiny")
library(shiny)
source("server.R")
my.ui <- fluidPage( 
  
  navbarPage("Foodborne Disease Outbreaks in the USA",
             
     # Introduction    
     
     tabPanel("Introduction"
        
     ),
             
     # Emma
     tabPanel("Trends over Time",
              
              sidebarLayout(
                sidebarPanel(
                  sliderInput('year', label='Year', min=1998, max=2015,
                              value=(c(1998,2015)), sep = ""),
                  # Make a list of checkboxes
                  selectInput('type', label='Choose Illnesses or Hospitalization', 
                              choices = c('Illnesses', 'Hospitalization'))
                ),
                mainPanel(
                  plotOutput('map_plot')
                )
              )
     ),
    
    
    
    
    
    
    
    
    
     # Daniel
     
     tabPanel("Worst Diseases",
              sidebarLayout(
                sidebarPanel(
                  textOutput("text"), 
                  sliderInput("year",
                              "Which Year?",
                              value = 2006,
                              min = 1998,
                              max = 2015, sep = "", animate = TRUE),
                  radioButtons("sort", label = "Get Table of",
                               choices = list('10 Most Recorded Diseases', '10 Least Recorded Diseases', 'All Recorded Diseases')
                  )
                ),
                mainPanel( tabsetPanel(type = "tabs",
                                       tabPanel("Worst Disease", tags$h3(textOutput("header")), br(), plotOutput("plot"), br(),  
                                                verbatimTextOutput("hover"), br(), tags$h4(textOutput("head")),textOutput("message"), br(),
                                                tags$h4(textOutput("head2")),
                                                textOutput("message2"), br(),tags$h4(textOutput("head3")), textOutput("message3")),
                                       tabPanel("Diseases", tags$h3(textOutput("header1")), br(), plotOutput("plot2"), textOutput("note"), 
                                                br(), dataTableOutput("table")), 
                                       tabPanel("Analysis & Thoughts", tags$h3(textOutput("head4")), tags$h4(textOutput("head5")), textOutput("message5")))
                )
              )
     ),
    
    
    # Gloriane
    
    tabPanel("Most Common Ingredients",
      sidebarLayout(
         sidebarPanel(
           sliderInput(
             'yearinput', label="Year", value = 2015, min = 1998, max = 2015
           ),
           
           radioButtons("radio", label = "Get Table of # of Recorded Contamination in:",
                        choices = c("Food", "Location")
           ),
          textOutput("analysis", container = div, inline = FALSE),
          textOutput("analysis2", container = div, inline = FALSE)
         ),
         mainPanel(
           plotOutput("food.plot"),
           tableOutput("food.table")
         )
       )
    ),
    
    
    
    
    
    
    
    # Rahul
    
    
    
    
    tabPanel("Advancement in Disease Treatments",    
             sidebarLayout(
               sidebarPanel(
                 selectizeInput(
                   'id', label="Year", choices=NULL, multiple=F, selected="X2015",
                   options = list(create = TRUE,placeholder = 'Choose the year')
                 ),
                 # Make a list of checkboxes
                 radioButtons("radio", label = h3("Radio buttons"),
                              choices = list("Choice 1" = 1, "Choice 2" = 2)
                 )
               ),
               mainPanel( )
             )
    )
    
  )
)

shinyUI(my.ui)