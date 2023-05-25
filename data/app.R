library(shiny)

source("final_project.r")

# Create introduction page
intro_pg <- tabPanel("Introduction",
  h1("A Comparative Analysis of Gentrification in Seattle's Chinatown and Wallingford (2013-2019)"),
  h4("By Aileen Kuang and Victoria Zhuang"),
  p("Gentrification occurs when affluent people and families move into neighborhoods 
  that have historically been home to Black, indigenous, and other people of color, 
  leading to the displacement of the original residents (Fogel, link). In the past 
  few decades, gentrification has become an increasingly important issue within major 
  U.S. cities. Developers and corporations often claim that gentrification increases
  the quality of life within target neighborhoods; however, in reality, it can also
  lead to a loss of culture, history, and feelings of connection between community members. 
  And, not only does gentrification impact culture, it threatens the food and housing 
  security of existing residents in gentrifying areas who may not be able to afford 
  increasing rent and food prices (Fogel).")
)

# Create analysis page 1: Comparing New Built Units in Chinatown and Wallingford (2013-2019)

# Create analysis page 2: Comparing White-to-Nonwhite Population Ratio in Chinatown and Wallingford (2013-2019)

# Create analysis page 3: Comparing Racial Demographics Breakdown in Chinatown and Wallingford (2013-2019)

# Create summary page 
summary_pg <- tabPanel("Project Summary"
                       
)

# Create UI 
ui <- navbarPage("INFO 201 Final Project",
  intro_pg,
  summary_pg,
)

# Create server
server <- function(input, output){
  
}

# Run app
shinyApp(ui, server)