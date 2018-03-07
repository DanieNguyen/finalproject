#install.packages("shiny")
library(shiny)

my.ui <- fluidPage( 
  
  navbarPage("Foodborne Disease Outbreaks in the USA",
             
    # Introduction    
     
     tabPanel("Introduction", h1("Looking at Foodborne Diseases Over Time"), 
              h4("Our group created this shiny application to analyze data about 
                foodborne diseases in the United States. We decided to analyze 
                this data set because we thought it was an interesting topic to 
                look at and that it was something all of us hadn't really paid 
                attention to before. The information in this application can be 
                used for greater good in society. Hospitals, doctors, and others 
                in the medical field may be able to use this information to better prevent foodborne diseases. "), br(),
              tags$b(h4("The main questions that we wanted to look at were:")), 
              tags$em(h4("1. Are there any trends over time of illnesses and hospitalizations based by State?")), 
              tags$em(h4("2. What are the most common foodborne diseases and are there any trends over time in types of diseases?")),
              tags$em(h4("3 .What are the common foods that cause foodborne diseases?")),
              tags$em(h4("4. How has the average number of hospitalizations from foodborne diseases changed over the years?")),
              br(),
              h4("	We felt that these questions would help identify common symptoms, triggers, and 
                     diseases that people in the medical field can pay attention to and hopefully prevent. "),
              br(), h4("	Here is the link to our dataset: "), 
              tags$a(href="https://www.kaggle.com/cdc/foodborne-diseases/data", 
                                                               "Food Borne Disease Outbreak Illness in USA - 1998-2005"), 
              br(), h4("Click through the navigation bar to see our information!")
              
        
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
             sliderInput("daniel.year",
                         "Which Year?",
                         value = 2006,
                         min = 1998,
                         max = 2015, sep = "", animate = TRUE),
             radioButtons("sort", label = "Get Table of",
                          choices = list('10 Most Recorded Diseases', '10 Least Recorded Diseases', 'All Recorded Diseases')
             )
           ),
           mainPanel( tabsetPanel(type = "tabs",
                                  tabPanel("Worst Disease", tags$h3(textOutput("header")), br(), plotOutput("plot"), br(), tags$h4(textOutput("head")),textOutput("message"), br(),
                                           tags$h4(textOutput("head2")),
                                           textOutput("message2"), br(),tags$h4(textOutput("head3")), textOutput("message3")),
                                  tabPanel("Diseases", tags$h3(textOutput("header1")), br(), plotOutput("plot2"), textOutput("note"), 
                                           br(), dataTableOutput("table")), 
                                  tabPanel("Analysis & Thoughts", tags$h3(textOutput("head4")), tags$h4(textOutput("head5")), textOutput("message5")))
            )
         )
      ),
      
      
      # Glorianne
      
      tabPanel("Most Common Foods",
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