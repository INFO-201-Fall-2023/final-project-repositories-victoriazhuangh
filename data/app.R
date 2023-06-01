library(shiny)
library(shinythemes)
source("final_project.r")
source("map_built_units.r")
source("plots.R")
source("plots_nonwhiteraces.R")

# Create introduction page ----
intro_pg <- tabPanel("Introduction",
                     fluidPage(theme = shinytheme("readable"),
                               
                               # Title
                               h1("Gentrification in Seattle: A Comparison of the Chinatown-International District
                                  and Wallingford (2013-2019)"),
                               
                               # Authors
                               h4("By Aileen Kuang and Victoria Zhuang"),
                               
                               h2("Project Question"),
                               h5("This project aims to examine the relationship between race, income, and gentrification. 
                               More specifically, we ask: What is the relationship between constructed/demolished units and racial/income demographics
                               in the International District? In Wallingford? How do existing population demographics influence the rate 
                               at which new developments appear, and how do new developments affect demographics?"),

                               h2("What is gentrification, and why is it important?"),
                               p("Gentrification results from the migration of affluent people into areas that have historically been
                               home to Black, indigenous, and other people of color, which displaces
                               those original residents. Developers and corporations often claim that gentrification
                               increases the quality of life within target neighborhoods; however, in reality, it can
                               also lead to a loss of culture, history, and feelings of connection between community
                               members. And, not only does gentrification impact culture, it threatens the food and housing
                               security of existing residents in gentrifying areas who may not be able to afford increasing
                               rent and food prices (Fogel)."),
                               
                               h2("Why Seattle, and why the CID and Wallingford?"),
                               p("When discussing gentrification, we believe that it is crucial to 
                                 recognize the ongoing displacement occuring throughout Seattle, which
                                 is the third most quickly gentrifying city in the United States (Fogel).
                                 The Chinatown-International District (also referred to as Chinatown or
                                 the CID), a neighborhood that is largely dominated by low-income, elderly
                                 Asian residents and has a history dating back to the beginning of
                                 the 1900s, has been named as one of the neighborhoods at 
                                 most risk of displacement in the city (Kuo, \"International District Development Wave\"). 
                                 Moreover, it has recently been identified as one of the eleven
                                 most endangered historic areas in the nation by the National Trust for
                                 Historic Preservation. With its rich history and cultural presence,
                                 further displacement in the CID would result in the continued loss 
                                 of culture and community."),
                               p("The CID is, consequently, a neighborhood that is useful for our study of 
                                 the relationship between racial demographics, income distribution,
                                 and gentrification/displacement. In this project, we compare Chinatown 
                                 to Wallingford (a North Seattle neighboorhood that is", em("extremely"), 
                                 "different from the CID in terms of racial demographics and economic 
                                 diversity -- it is largely populated by high-income and white 
                                 individuals) to further highlight a possible relationship between 
                                 race, income, and displacement."),
                               p("In the making of this project, we also chose to only examine the data
                                 for the years 2013-2019. Because of the COVID-19 pandemic, the data for 
                                 2020 may be misrepresentative of patterns in gentrification."),

                               br(),
                               div(img(src = "https://www.theurbanist.org/wp-content/uploads/2022/06/china-gat-696x750.png",
                                       height = "300px",
                                       width = "300px"),
                                   style="text-align: center; margin-bottom: 6px;"),
                               div(tags$figcaption("From Kuo, \"Watching Chinatown’s Gentrifying/Generational Change.\" These 
                               images depict a building in Chinatown eight years apart -- the bottom image is from 2008, and the 
                                                   top image is from 2016."), style="text-align: center;"),
                               br(),
                               
                               h2("Data Used"),
                               
                               p("This project uses the following data:"),
                               tags$ol(
                                 tags$li(a(href = "https://data-seattlecitygis.opendata.arcgis.com/datasets/SeattleCityGIS::built-units-since-2010/explore?location=47.614500%2C-122.330455%2C12.00&showTable=true",
                                           "Built Units Since 2010"), "from City of Seattle GIS Progam. This data set 
                                           provides information about built and demolished units in Seattle (a 
                                           \"unit\" does not refer to an entire building, but individual home/business 
                                           spaces within a building). Such information is useful in our project, as 
                                           construction and demolition patterns can lead to insights about an area's rate 
                                           of gentrification."),
                                 tags$li(a(href = "https://data-seattlecitygis.opendata.arcgis.com/datasets/SeattleCityGIS::census-block-groups-2010/explore?location=47.608203%2C-122.341500%2C12.00",
                                           "Census Block Groups 2010"), "from City of Seattle GIS Program. This data set 
                                            provides a shapefile of Seattle. We use this shapefile throughout our project to map our data."),
                                 tags$li(a(href = "https://data.census.gov/table?q=table+b02001&g=050XX00US53033$1500000&tid=ACSDT5Y2020.B02001",
                                           "Table B02001"), "from the U.S. Census. This data provides information about the 
                                           racial makeup of block groups in the United States."),
                                 tags$li(a(href = "https://data.census.gov/table?q=american+community+survey+economics&t=Income+and+Poverty&g=050XX00US53033$1500000&tid=ACSDT5Y2021.B19001",
                                           "Table B19001"), "from the U.S. Census. This data provides information about the 
                                           income distribution of block groups in the United States.")
                               ),
                               
                               h2("References"),
                               a(href= "https://www.historylink.org/file/3461",
                                 "Dorpat, Paul. \"Seattle Neighborhoods: Wallingford — Thumbnail History.\""),
                               br(),
                               a(href = "https://urban.uw.edu/news/gentrification-and-changing-foodscapes-in-seattle/#:~:text=In%20Seattle%2C%2050%25%20of%20eligible,47%25%20between%202000%20and%202013",
                                 "Fogel, Rebecca. \"Gentrification and changing foodscapes in Seattle.\""),
                               br(),
                               a(href = "https://www.theurbanist.org/2022/06/14/kuo-%E9%83%AD-watching-chinatowns-gentrifying-generational-change/",
                                 "Kuo, Shawn. \"Watching Chinatown’s Gentrifying/Generational Change.\""),
                               br(),
                               a(href = "https://www.theurbanist.org/2022/03/22/cid-growing-pains-and-opportunities/",
                                 "Kuo, Shawn. \"International District Development Wave Comes with Growing Pains and Opportunities.\""),
                               br(),
                               a(href = "https://www.seattletimes.com/seattle-news/transportation/seattle-neighborhood-placed-on-unfortunate-historic-places-list/",
                                 "Lindblom, Mike and Yoon-Hendricks, Alexandra. \"Seattle neighborhood placed on unfortunate historic places list.\""),
                               br(),
                               a(href = "https://www.niche.com/places-to-live/n/wallingford-seattle-wa/residents/", "Niche. \"Wallingford.\""),
                               br(),
                               a(hred = "https://www.niche.com/places-to-live/n/international-district-seattle-wa/residents/", "Niche. \"Chinatown.\""),
                     )
)

# Create analysis page 1: Comparing New Built Units in Chinatown and Wallingford (2013-2019) ----

built_units_pg <- tabPanel("Constructed and Demolished Units",
                           fluidPage(
                             # Create title
                             titlePanel("Comparing Constructed and Demolished Units in Chinatown and Wallingford (2013-2019)"),
                             
                             p("The number of constructed and demolished units in an area can be an indicator of gentrification 
                             or displacement -- an increase in built and demolished units may suggest that the area is quickly being 
                             gentrified. So, in the maps below, we examine the spatial distribution of constructed and demolished units
                             in Chinatown and Wallingford by year. To view maps for a specific year, use the dropdown menu."),
                             
                             # Create sidebar layout
                             sidebarLayout(
                               # Select a year on the sidebar
                               sidebarPanel(
                                 selectInput(inputId = "year",
                                             label = "Year",
                                             choices = c(2013, 2014, 2015, 2016, 2017, 2018, 2019)),
                                 width = 2
                               ),
                               
                               mainPanel(
                                 # Display maps associated with the selected year
                                 fluidRow(
                                   column(7.5, wellPanel(plotOutput(outputId = "map_new"))),
                                   column(7.5, wellPanel(plotOutput(outputId = "map_demo")))
                                 )
                               )
                             ),
                             
                             p("From scrolling through these maps, we can notice that:"),
                             tags$ol(
                               tags$li("Until 2016, the number of constructed
                                       units in Chinatown is significantly less than that of Wallingford."),
                               tags$li("The spatial centers of construction and 
                                       demolition vary year-by-year for both neighborhoods."),
                             ),
                             
                             br(),
                             
                             p("We have also created line charts that summarize the rate of 
                             construction and demolition of units in both neighborhoods (shown below). To view 
                             the specific number of units constructed or demolished for a single
                             year, hover your mouse over that point in the line."),
                             
                             fluidRow(
                               column(6, wellPanel(plotlyOutput(outputId = "cid_line_plot"))),
                               column(6, wellPanel(plotlyOutput(outputId = "wall_line_plot")))
                             ),
                             
                             p("From these graphs, we can see that while the rate of demolition remains relatively stable and similar
                             in Chinatown and Wallingford, we can see that the rate of construction is significantly different:
                             while the rate of construction is generally increasing in Chinatown, the rate of construction is
                             generally decreasing in Wallingford (though it is also important to note that the rate of
                             construction is not steadily increasing in either neighborhood)."),
                             
                             p("Some other key takeaways from these graphs are:"),
                             tags$ol(
                               tags$li("The relative difference between the rate of demolition and construction differs between
                               the two neighborhoods -- as time passes, it increases in Chinatown but decreases in Wallingford.
                               Moreover, the rates of demolition and construction remain vastly different in Wallingford;
                               however, in Chinatown, they almost intersect twice."),
                               tags$li("The rates of construction changed drastically in 2018 for both neighborhoods. In
                               Wallingford, the number of constructed units dropped drastically, but the number of
                               constructed units rose drastically in Chinatown.")
                             )
                           ),
                           
                           p("All in all, the trends seen in the maps and line charts indicate that Chinatown is facing an increasing 
                             rate of gentrification, while the rate of gentrification is decreasing in Wallingford. This is consistent 
                             with much of the narratives presented about displacement in the CID. To further examine these trends in 
                             relation to race, please continue to the next tab.")
)

# Create analysis page 2: Comparing White-to-Nonwhite Population Ratio in Chinatown and Wallingford (2013-2019) ----
comp_white_pg <- tabPanel("Racial Demographics",
                          
                          fluidPage(
                            titlePanel("Comparing White and Non-white Populations in Chinatown and Wallingford (2013-2019)"),
                            
                            br(), 
                            
                            p("The graphs below display the racial distribution throughout the years in Chinatown and Wallingford. 
                              To see specific percentages, hover your cursor over the bars and you will be able to track the changes in race distribution over the years."),
                            
                            fluidRow(
                              column(6, wellPanel(plotlyOutput(outputId = "cid_nw_w"))),
                              column(6, wellPanel(plotlyOutput(outputId = "wall_nw_w")))
                            ),
                            
                            p("These first two bar charts showcase the overall white versus non-white race distribution between the two districts. 
                            As seen above, Chinatown is a predominately non-white district while Wallingford is a predominantly white district. 
                            According to patterns of gentrification, communities like Chinatown, which predominantly involve non-white residents, should have seen a higher rate of displacement among original residents, meaning that the number of white residents were predicted to increase. 
                            However, our data shows the opposite. In recent years, despite the amount of newly built units, the number of non-white residents in Chinatown has risen."),
                      
                          
                            fluidRow(
                              column(6, wellPanel(plotlyOutput(outputId = "cid_nwn_line"))),
                              column(6, wellPanel(plotlyOutput(outputId = "wall_wnw_line")))
                            ),
                            
                            p("Compared to Chinatown, Wallingford, a predominantly white district, has seen a decrease in its White population despite the implications that gentrification would lead to an increase in the white population. 
                            Instead, the non-white residents of Wallingford have steadily increased over the past few years. 
                            Although both areas have seen an increase in non-white residents, the trend line for Chinatown appears steeper and starts at around 2017 while Wallingfords non-white residents trend line appears to be more gradual starting in 2018. "),
                            
                            
                            br(),
                            
                            p("The racial demographics of Chinatown and Wallingford seem to contradict the implications of gentrification."),
                            
                            
                            fluidRow(
                              column(6, wellPanel(plotlyOutput(outputId = "cid_dem"))),
                              column(6, wellPanel(plotlyOutput(outputId = "wall_dem")))
                            ),
                            
                            p("In order to examine this phenomenon further, we have presented two barcharts with their accompanying line charts, highlighting the non-white racial distribution in both districts. 
                            Chinatown’s non-white racial demographic displays Asians as the predominant race, which correlates to the districts history of Asian immigrants. 
                            There is also some intersectionality in past years with Black residents but this intersectionality disappears nearing 2017 when black residents decreased in a steady decline while Asian residents increased. 
                            As of 2019, Asian residents are nearly 47% of the whole population. Similarly, in Wallingford, the predominant non-white race are Asians who make up around 15% of the overall district population by 2019. 
                            However, unlike Chinatown, Asians remain the predominant non-white race without intersectionality for the existing timeline. "), 
                            
                            fluidRow(
                              column(6, wellPanel(plotlyOutput(outputId = "cid_race_line"))),
                              column(6, wellPanel(plotlyOutput(outputId = "wall_race_line")))
                            ),
                            
                            p("The data for race demographics seem to defy the perceived implications of gentrification. 
                              Yet does this data prove that gentrification does not exist in these two districts? 
                              Purely relying on racial demographics might not give us enough information.")
                          )
)

# Create analysis page 3: Comparing Income Distribution in Chinatown and Wallingford (2013-2019) ----

income_pg <- tabPanel("Income Distribution",
                      fluidPage(
                        titlePanel("Comparing the Income Distribution of Chinatown and Wallingford (2013-2019)"),
                        
                        p("The trends we noticed in the racial demographics of both neighborhoods were surprising.
                        So, we turn to the income distribution to see whether it is consistent with what we know
                        about gentrification. We examine this data for Chinatown and Wallingford in the maps below --
                        select a year from the dropdown menu to display the maps for that year."),
                        
                        # Create sidebar layout
                        sidebarLayout(
                          # Select a year on the sidebar
                          sidebarPanel(
                            selectInput(inputId = "inc_year",
                                        label = "Year",
                                        choices = c(2013, 2014, 2015, 2016, 2017, 2018, 2019)),
                            width = 2
                          ),
                          
                          mainPanel(
                            # Display maps associated with the selected year
                            plotOutput(outputId = "map_inc"))
                        )
                      ),
                      
                      p("Here are some main takeaways from these maps:"),
                      
                      tags$ol(
                        tags$li("From 2013 to 2019, Chinatown was largely dominated by those with a
              yearly income of less than $10,000. However, from 2016 to 2018, the
              eastern-most block group in the neighborhood became dominated by
              those with a yearly income of $150,000-$199,999; this is consistent with
              the uptick of constructed units in that area (shown in our prior maps).
              The abundance of built units during that time frame is, then, a possible
              explanation for this sudden change in the income distribution of this area."),
                        tags$li("While the dominant income brackets in Chinatown remained relatively stable, the dominant income
              groups in Wallingford varied greatly as time passed. In 2013, the neighborhood exhibited high
              economic diversity, as three block groups were mostly populated by those making less than $10,000
              a year, three block groups were mostly populated by those making $200,000 or more,
              and the other five block groups were dominated by different income groups. However,
              in 2019, Wallingford became", em("much"), "less economically diverse -- five of the
              eleven block groups were dominated by those with a yearly income of $200,000 or more.
              This is surprising, as the number of constructed units in the units
              seem to be decreasing as the years go on."),
                        tags$li("The spatial distribution of the dominant income groups in Wallingford and Chinatown
              is also interesting to note, especially in comparison to the number of units built over the years.
              In Wallingford, there are three eastern-most block groups that remain dominated by those with a
              yearly income of less than $10,000; incidentally, those same block groups also experience
              the most construction in later years. Similarly, in Chinatown, the western-most block groups
              (which are also the block groups that remain populated by low-income individuals) experience
              the most construction in 2019. Because our analysis ends at 2019, it may not be sufficient
              enough to confirm whether construction in low-income areas leads to high displacement.")
                      )
)



# Create UI  ----
ui <- navbarPage("INFO 201 Final Project",
                 intro_pg,
                 built_units_pg,
                 comp_white_pg,
                 income_pg
)

# Create server ----
server <- function(input, output){
  
  output$map_new <- renderPlot({
    year_sf <- aggregate(input$year)
    map <- make_map_new(input$year, year_sf)
    return(map)
  })
  
  output$map_demo <- renderPlot({
    year_sf <- aggregate(input$year)
    map <- make_map_dem(input$year, year_sf)
    return(map)
  })
  
  output$cid_line_plot <- renderPlotly({
    return(cid_line)
  })
  
  output$wall_line_plot <- renderPlotly({
    return(wall_line)
  })
  
  output$cid_nw_w <- renderPlotly({
    return(cid_bar)
  })
  
  output$wall_nw_w <- renderPlotly({
    return(wall_bar)
  })
  
  output$cid_dem <- renderPlotly({
    return(chinatown_bar)
  })
  
  output$wall_dem <- renderPlotly({
    return(wallingford_bar)
  })
  
  output$cid_race_line <- renderPlotly({
    return(chinatown_line)
  })
  
  output$wall_race_line <- renderPlotly({
    return(wallingford_line)
  })
  
  output$cid_nwn_line <- renderPlotly({
    return(chinatown_wnw_line)
  })
  
  output$wall_wnw_line <- renderPlotly ({
    return(wallingford_wnw_line)
  })
  
  output$map_inc <- renderPlot({
    if (input$inc_year == 2013){
      make_inc_map(2013, sf_2013)
    } else if (input$inc_year == 2014){
      make_inc_map(2014, sf_2014)
    } else if (input$inc_year == 2015){
      make_inc_map(2015, sf_2015)
    } else if (input$inc_year == 2016){
      make_inc_map(2016, sf_2016)
    } else if (input$inc_year == 2017){
      make_inc_map(2017, sf_2017)
    } else if (input$inc_year == 2018){
      make_inc_map(2018, sf_2018)
    } else if (input$inc_year == 2019){
      make_inc_map(2019, sf_2019)
    }
  })
  
}

# Run app ----
shinyApp(ui, server)