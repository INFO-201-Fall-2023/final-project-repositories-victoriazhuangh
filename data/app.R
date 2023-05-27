library(shiny)
source("final_project.r")
source("map_built_units.r")

# Create introduction page ----
intro_pg <- tabPanel("Introduction",
  
  # Title 
  h1("Gentrification in Seattle: A Comparison of the Chinatown-International District
     and Wallingford (2013-2019)"),
  
  # Authors 
  h4("By Aileen Kuang and Victoria Zhuang"),
  
  h2("So, what is gentrification, and why is it important?"),
  p("Gentrification results from migration of affluent people into areas that have
  historically been home to Black, indigenous, and other people of color, which displaces
  those original residents. Developers and corporations often claim 
  that gentrification increases the quality of life within target neighborhoods; however, 
  in reality, it can also lead to a loss of culture, history, and feelings of connection 
  between community members.  And, not only does gentrification impact culture, it threatens 
  the food and housing security of existing residents in gentrifying areas who may not 
  be able to afford increasing rent and food prices (Fogel)."),
  
  h2("Why Seattle, and why the CID and Wallingford?"),
  p("When discussing gentrification, it is important to recognize the ongoing displacement
    in Seattle, the third most quickly gentrifying city in the United States after Washington, D.C.
    and Portland (Fogel). An example of a gentrifying neighborhood in Seattle is the 
    Chinatown-International District (CID), which has a history dating back to the beginning
    of the twentieth century (UW), has been identified as one of the neighborhoods facing the
    most risk of displacement (Kuo). With its rich history and cultural presence in Seattle,
    displacement of the CID would result in the loss of culture and community along with homes and 
    local businesses. Additionally, Wallingford (a North Seattle neighborhood that has close proximity
    to Lake Union and the University District) has faced gentrification in recent history ‒ after the 
    Boeing slump in the late twentieth century, the prices of Wallingford homes rapidly increased (Dorpat).
    The rising home and living prices would have likely led to the displacement of preexisting residents 
    in the area."),
  p("We can see that both Wallingford and the CID have been impacted by gentrification. There is, however,
    a key difference between the two neighborhoods: Wallingford is predominantly white, while
    the CID is not (Niche). This difference suggests that the gentrification faced in both neighborhoods 
    is not equal; therefore, in our project, we will explore and compare gentrification in the Chinatown-International
    District and Wallingford for the years 2013-2020."),
  h5("More specifically, we ask: What is the relationship between built units and racial/income demographics 
    in the International District? In Wallingford? How do existing population demographics influence the rate 
    at which new developments appear, and how do new developments affect demographics?"),
  
  h2("Data Used"),
  
  h2("References"),
  
  h2("Resources")
  )

# Create analysis page 1: Comparing New Built Units in Chinatown and Wallingford (2013-2019) ----

built_units_pg <- tabPanel("Built and Demolished Units",
  fluidPage(
    # Create title 
    titlePanel("Comparing New and Demolished Units in Chinatown and Wallingford (2013-2019)"),
    h3("Instructions for Use"),
    p("We have created maps to display the number of new and demolished units in
      both neighborhoods by year. Select a year from the dropdown menu to display
      the maps for that year."),
    h3("Map Display"),
    
    # Create sidebar layout
    sidebarLayout(
      # Select a year on the sidebar 
      sidebarPanel(
        selectInput(inputId = "year", 
                    label = "Select a Year",
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
    )
  )
)

# Create analysis page 2: Comparing White-to-Nonwhite Population Ratio in Chinatown and Wallingford (2013-2019) ----
comp_white_pg <- tabPanel("White and Non-White Populations",
  h1("Compare")
)

# Create analysis page 3: Comparing Racial Demographics Breakdown in Chinatown and Wallingford (2013-2019) ----

# Create summary page ----
summary_pg <- tabPanel("Project Summary"
                       
)

# Create UI  ----
ui <- navbarPage("INFO 201 Final Project",
  intro_pg,
  built_units_pg, 
  comp_white_pg,
  summary_pg
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
  
}

# Run app ----
shinyApp(ui, server)