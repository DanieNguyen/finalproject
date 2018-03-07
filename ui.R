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
          selectizeInput(
          'id', label="Year", choices=NULL, multiple=F, selected="X2015",
          options = list(create = TRUE,placeholder = 'Choose the year')
          ),
          # Make a list of checkboxes
          radioButtons("radio", label = h3("Radio buttons"),
          choices = list("Choice 1" = 1, "Choice 2" = 2)
          )
        ),
        mainPanel(textOutput("text"))
        )
    ),
    
    
    
    
    
    
    
    
    
    
    # Daniel
    
    tabPanel("Seasonal Foods",
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
         mainPanel(textOutput("text")
         )
       )
    ),
    
    
    # Gloriane
    
    tabPanel("Most Common Ingredients",
      sidebarLayout(
         sidebarPanel(
           sliderInput(
             'year', label="Year", value = 2015, min = 1998, max = 2015
           )
         ),
         mainPanel(
           textInput('text', label = "Write"),
           plotOutput("food"),
           plotOutput("location")
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
        mainPanel(textOutput("text")
        )
      )
    )
  )
)



shinyUI(my.ui)