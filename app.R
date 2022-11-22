library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
ui <- shinydashboard::dashboardPage(
  shinydashboard::dashboardHeader(title="Shiny Application"),
  shinydashboard::dashboardSidebar(div(selectInput(label="Select data",inputId="s1",choices=c('mtcars','airquality')),
  ),actionButton(label="Click",inputId="ac1")),
  shinydashboard::dashboardBody(dataTableOutput("id"))
)
server <- function(input, output,session){
  dat <- reactive({
    
    get(input$s1)
  })
  observeEvent(input$ac1,{
    output$id<-renderDataTable({
      dat() %>% DT::datatable(filter="top",extensions = "Buttons")
    })
  })
  
  
}
shinyApp(ui = ui, server = server)