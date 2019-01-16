library(cranlogs)
library(dplyr)
library(lubridate)
library(ggplot2)
library(shiny)

# Define UI for specifying package and plotting cranlogs ------------
ui <- fluidPage(
  tags$script(HTML(
    "$(document).keyup(function(event) {
      if ($('#packages').is(':focus') && (event.keyCode == 13)) {
          $('#update').click();
      }
    });
    $('#update').hide();"
  )),
  sidebarLayout(
    sidebarPanel(
      textInput("packages", "Package names (comma separated)", value ="shiny"),
      actionButton("update", "Update"),
      br(), br(),
      dateRangeInput("dates", label = "Date Range", start = "2016-01-01", end = "2019-01-01")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic for downloading and parsing cranlogs ----------
server <- function(input, output, session) {
  
  # Parses comma-separated string into a proper vector
  packages <- reactive({
    strsplit(input$packages, " *, *")[[1]]
  })
  
  # Daily downloads
  daily_downloads <- eventReactive(c(input$update, input$dates), { # Vector of conditions!
    cranlogs::cran_downloads(
      packages = packages(),
      from = input$dates[1], to = input$dates[2]
    )
  })
  
  # Weekly downloads
  weekly_downloads <- reactive({
    daily_downloads() %>% 
      mutate(date = ceiling_date(date, "week")) %>%
      group_by(date, package) %>%
      summarise(count = sum(count))
  })
  
  
  # Plot weekly downloads, plus trendline
  output$plot <- renderPlot({
    ggplot(weekly_downloads(), aes(date, count, color = package)) +
      geom_line() +
      geom_smooth()
  })
}

# Run the app -------------------------------------------------------
shinyApp(ui, server)
