#install.packages("shiny")
library(shiny)
source("server.R")
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
                                  tabPanel("Analysis & Thoughts", tags$h3(textOutput("head4")), tags$h4(textOutput("head5")), textOutput("message5"), 
                                          br(), p("Looking at the worst disease bar graph, there is a clear trend over the years. 
                                            The worst diseases from 1998 - 2015 are only three different diseases: 
                                            Salmonella enterica, Norovirus genogroup 1, and Norovirus genogroup 2. 
                                            There was a large span of Norovirus genogroup 1 being the worst disease from 1999 until 2007. 
                                            The most recent years seem to alternate between Salmonella enterica and Norovirus genogroup 2.
                                                  There seems to be no correlation between months and the foodborne diseases since the count of the diseases for each 
                                                  month seem to vary for each year."),
                                          br(), p("For the 10 worst diseases, there were clear leaders. The top three unsurprisingly were the three diseases from
                                                  the worst disease tab. At least one of the three were almost double the rest of the diseases for most of the years.
                                                  An interesting trend was the rise of Norovirus genogroup 2, it wasn't prominent in the first decade but started growing rapidly.
                                                  One positive trend was that the record of illnesses were going down overall, from having a max of 7000 records on the scale to a max of 3000.
                                                  This shows that foodborne diseases are becoming less of a problem due to advances in the medical field. However, we definitely need
                                                  to focus on Salmonella and Norovirus for the future.")))
            )
         )
      ),
      
      
      # Gloriane
    
    tabPanel("Most Common Foods & Locations",
      sidebarLayout(
         sidebarPanel(
           sliderInput(
             'yearinput', label="Year", value = 2015, min = 1998, max = 2015, sep = ""
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