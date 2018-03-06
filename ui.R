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
    

  
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    # Glorianne
    
    tabPanel("Most Common Ingredients"
             
    ),
    
    
    
    
    
    
    
    # Rahul
    
    
    
    
    tabPanel("Advancement in Disease Treatments"   
          
    )
  )
)

shinyUI(my.ui)