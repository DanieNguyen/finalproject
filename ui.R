#install.packages("shiny")
library(shiny)
source("server.R")
my.ui <- fluidPage( 
  
  navbarPage("Foodborne Disease Outbreaks in the USA",
             
    # Introduction    
     
    tabPanel("Introduction", h1("Looking at Foodborne Diseases Over Time"), 
             h4("Foodborne illness is a serious and underreported public 
                health problem with high health and financial costs.
                The original dataset that we used summarized data of foodborne 
                disease from 1998 to 2015 for each state, and the data 
                shows the location, type of food, species and genotype 
                that causes foodborne disease. Our group analysis is to clearly 
                show the trends over the years and by state for food diseases and the percentage of 
                the foods, locations that cause most of the diseases. We wish 
                the information can be used for greater good in society. 
                Hospitals, doctors, and others in the medical field may be 
                able to use this information to better prevent foodborne 
                diseases. "), br(),
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
         sliderInput('emma.year', label='Year', min=1998, max=2015,
                     value=(c(1998,2015)), sep = ""),
         # Make a list of checkboxes
         selectInput('emma.type', label='Choose Illnesses or Hospitalizations', 
                     choices = c('Illnesses', 'Hospitalizations'))
       ),
       mainPanel(
         tabsetPanel(type = "tabs",
           tabPanel("Map",
              plotOutput('map'),
              h4("How to Read This Map"),
              p("This map shows the average number of illnesses and hospitalizations from foodborne diseases for each 
                state. You can interact with the map by dragging the slider on the right to choose the year range. The map is coded
                by color. The ",
                strong("darker "), "the state means the state has a ", 
                strong("high "), "average number of illnesses and hospitalizations
                , and the ", strong("lighter "), "the color of 
                the state, the ", strong("lower "), "number of Illnesses and
                hospitalization is for the state."),
              h4("Analysis"),
              p("Looking at the map, it is clear that California and Florida consistently had a large number of foodborne illnesses.
                We were thinking that its because of the hot weather is easier for bacteria to survive in and because of the
                large populations in both states. Illinois is also a state with a consistently large number of foodborne illnesses over the years. 
                We were surprised by this as it didn't seem likely; however, Illinois has the 5th largest state population in the US, so it follows
                our trend.")
              ),
           tabPanel("Trend",
              plotOutput('trend'),
              h4("How to Read This Graph"),
              p("This graph shows the total number of illnesses and hospitalizations from foodborne diseases over the years. 
                You can interact with the map by dragging the slider on the right to choose the year range."),
              h4("Analysis"),
              p("The trend of illnesses in USA has ", strong("decreased"), " over 
                the years. We think it is probably because of the government awareness 
                of these illnesses and stricter regulations for food preparation.
                However, the number of hopitalized people 
                remains at a ", strong("constant"), "level. We believe that this implies that people 
                are hospitalized due to increasing levels of income that 
                support people to spend more on health, and the increasing 
                level of life expectancy reflects how people focus more on 
                health. More people can afford to go
                to the hospital when they get foodborne diseases due to health insurance plans.")
              )
            )
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
    
  tabPanel("Most Common Foods and Locations",
           sidebarLayout(
             sidebarPanel(
               sliderInput('yearinput', label = "Year", value = 2015, min = 1998, max = 2015, sep = ""),
               radioButtons("radio", label = "Get Tabel of # of Recorded Contamination in:", choices = c("Food", "Location")),
               tags$blockquote(textOutput("analysis", container = div, inline = FALSE)),
               tags$blockquote(textOutput("analysis2", container = div, inline = FALSE))
             ),
             mainPanel(
               tabsetPanel(type = "tabs", 
                           tabPanel("Popular Foods and Locations for Foodborne Diseases",
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