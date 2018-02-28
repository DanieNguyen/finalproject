#install.packages("shiny")
library(shiny)

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
    
    
    # Glorianne
    
    tabPanel("Most Common Ingredients",
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