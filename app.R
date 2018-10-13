
library(shiny)
# getwd()
# setwd("E:\\Rlang_week\\181013\\USAMap")
install.packages("maps")
library(maps)
library(mapproj)
source("helpers.R")
counties <- readRDS("counties.rds")
head(counties)
ui <- fluidPage( titlePanel("censusVis"),
                 
                 sidebarLayout(
                   sidebarPanel(
                     helpText("Create demographic maps with 
                              information from the 2010 US Census."),
                     
                     selectInput("var", 
                                 label = "Choose a variable to display",
                                 choices = c("Percent White", "Percent Black",
                                             "Percent Hispanic", "Percent Asian"),
                                 selected = "Percent White"),
                     
                     sliderInput("range", 
                                 label = "Range of interest:",
                                 min = 0, max = 100, value = c(0, 100))
                     ),
                   
                   mainPanel(plotOutput("map"))
                 )
)

server <- function(input, output) {
   
   output$map <- renderPlot({
     data <- switch(input$var, 
                    "Percent White" = counties$white,
                    "Percent Black" = counties$black,
                    "Percent Hispanic" = counties$hispanic,
                    "Percent Asian" = counties$asian)
     
     percent_map(var = data,
                 color = 'blue',
                 legend.title = 'Test',
                 max = 100,
                 min = 1
                 )
   })
}

shinyApp(ui = ui, server = server)

