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
              tags$em(h4("4. How has the number of fatalities from foodborne diseases changed over the years?")),
              br(),
              h4("	We felt that these questions would help identify common symptoms, triggers, and 
                     diseases that people in the medical field can pay attention to and hopefully prevent. "),
              br(), h4("	Here is the link to our dataset: "), 
              tags$a(href="https://www.kaggle.com/cdc/foodborne-diseases/data", 
                                                               "Food Borne Disease Outbreak Illness in USA - 1998-2005"), 
              br(), h4("Click through the navigation bar to see our information!"),
              img(src='http://www.eufic.org/images/uploads/food-safety/landing-food-safety.jpg',
                  align = "center", width = "60%", height = "60%", inline = FALSE),
              tags$em(p("Image used from www.eufic.org", size = "10px"))
        
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
    
    tabPanel("Most Common Ingredients",
      sidebarLayout(
        sidebarPanel(
          sliderInput('yearinput', label = "Year", value = 2015, min = 1998, max = 2015),
          radioButtons("radio", label = "Get Tabel of # of Recorded Contamination in:", choices = c("Food", "Location")),
          tags$blockquote(textOutput("analysis", container = div, inline = FALSE)),
          tags$blockquote(textOutput("analysis2", container = div, inline = FALSE))
        ),
        mainPanel(
          tabsetPanel(type = "tabs", 
            tabPanel("Contaminated Food that causes Foodborne Illness and Location Site",
                      plotOutput("food.plot"),
                      verbatimTextOutput("plot_clickinfo"),
                      tableOutput("food.table")),
            tabPanel("Analysis & Thoughts",
                     tags$b(h3(textOutput("glo.head1"))),
                     tags$p(textOutput("glo.analysis")),
                     tags$a(href = "https://www.fsis.usda.gov/wps/portal/fsis/home",
                           "Click here for more reference about Food Safty and Inspection Service"),
                     tags$b(h3(textOutput("glo.head2"))),
                     img(src=' https://publichealthskc.files.wordpress.com/2016/12/restaurant-window-for-blog-banner.png',
                         align = "center", width = "60%", height = "60%", inline = FALSE),
                     tags$em(p("Image used from publichealthskc.files.wordpress.com", size = "10px")),
                     tags$p(textOutput("glo.analysis2")),
                     tags$li(textOutput("glo.analysis3")),
                     tags$li(textOutput("glo.analysis4")),
                     tags$li(textOutput("glo.analysis5")),
                     tags$li(a(href = "https://www.cdc.gov/features/salmonellachicken/index.html",
                            "Click here for more steps and advice how to prepare chicken")),
                     tags$li(a(href = "http://www.eufic.org/en/food-safety/category/safe-food-handling",
                               "Click here for more safe food handling ways")),
                     img(src='http://www.eufic.org/images/uploads/food-safety/foodsafety_safefoodhandling_1611.png',
                         align = "center", width = "60%", height = "60%", inline = FALSE),
                     tags$em(p("Image used from www.eufic.org", size = "10px"))
            )
          )
        )
      ) 
    ),
      
      
      
      
      # Rahul
      
      
      
      
  tabPanel("Fatalities over Time",    
           sidebarLayout(
             sidebarPanel(
               sliderInput(
                 'fatalityslider', label = "Year", min = 1998,max = 2015, value = 2015, step = 1,sep=""
               )
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Plot", plotOutput("fatalitiesplot"), 
                          h4("How to use this Graph"), 
                          em(),
                          p("This graph shows the fatalities per month by foodborne illness for a specific year 
                            between 1998 and 2015. With the slider at the right you can 
                            control which year the bar graph is displaying. The larger the 
                            bar in a certain month the more fatalities there were in that month relative to the other
                            months in the year.")), 
                 tabPanel("Data Analysis",
                          h2("What does this mean?"), 
                          em(), 
                          p("When we look at the data for fatalities we can see a few interesting things.
                            One is that for many months there are no fatalities so we can know
                            that fatalities are not as ubiquitous as one may think. With food safety regulations
                            we can see that they are effective in keeping the fatalities generally low. Also, when there is a spike
                            it seems to occur in different months throughout the year.
                            This can tell us that there is no strong correlation between the month and the fatalities
                            which occured. "), 
                          em(),
                          p("Between 1998 and 2015 although fatalities were relatively low,
                             they did not decrease significantly over this time. We can see in 
                            particular in 2011 that there was a large spike in fatalities in July. 
                            This can tell us that even after all this time there are still foodborne illnesses
                            that are still a serious concern for all of us.")
                          )
               )
             )
           )
    )
  

  )
)

shinyUI(my.ui)