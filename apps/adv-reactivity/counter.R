library(shiny)

# Define UI for counter ---------------------------------------------
ui <- fluidPage(
  actionButton("increment", "Increment"),
  actionButton("decrement", "Decrement"),
  actionButton("reset", "Reset"),
  
  p(
    textOutput("value")
  )
)

# Define server logic -----------------------------------------------
server <- function(input, output, session) {
  #rv <- list(x=5) # To prove this has to be reactive
  
  rv <- reactiveValues(x=0)
  
  output$value <- renderText({
    rv$x
  })
  
  observeEvent(input$increment,{
    rv$x <- rv$x+1
  })
  observeEvent(input$decrement,{
    rv$x <- rv$x-1
  })
  observeEvent(input$reset,{
    rv$x <- 0
  })
}

# Run the app -------------------------------------------------------
shinyApp(ui, server)
