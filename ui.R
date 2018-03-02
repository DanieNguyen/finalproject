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
          mainPanel()
        )
      ),
      

      
      
      # Daniel
      
      tabPanel("Worst Months for Food Disease",
         sidebarLayout(
           sidebarPanel(
             textOutput("text"), 
             sliderInput("year",
                         "Which Year?",
                         value = 2006,
                         min = 1998,
                         max = 2015, sep = ""),
             selectInput("month", "Which Month?", choices = c("January", "February", "March", "April", "May", "June", "July", "August",
                                                     "September", "October", "November", "December"), selected = "January", multiple = FALSE)
           ),
           mainPanel( tabsetPanel(type = "tabs",
                                  tabPanel("Map"),
                                  tabPanel("Table", br(), dataTableOutput("table")))
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
           mainPanel()
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