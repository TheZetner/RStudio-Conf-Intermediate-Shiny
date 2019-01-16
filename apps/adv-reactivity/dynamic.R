library(shiny)
library(ggplot2)

# Define UI for dynamic UI ------------------------------------------
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "CSV file"),
      uiOutput("field_chooser_ui")
    ),
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("summary")
    )
  )
)

# Define server logic for summarizing selected file ------------------
server <- function(input, output, session) {
  
  # Load data
  full_data <- reactive({
    req(input$file)
    read.csv(input$file$datapath, stringsAsFactors = FALSE)
  })
  
  # Subset for specified columns
  subset_data <- reactive({
    req(input$xvar, input$yvar) # really important sort of thing to catch: an error will pop up very quickly and look terrible to the end user
    full_data()[, c(input$xvar, input$yvar)]
  })
  
  # Dynamic UI for variable names based on selected file
  output$field_chooser_ui <- renderUI({
    req(full_data())
    col_names <- names(full_data())
    tagList(
      selectInput("xvar", "X variable", col_names),
      selectInput("yvar", "Y variable", col_names, selected = col_names[[2]])
    )
  })
  
  # Scatterplot of selected variables
  output$plot <- renderPlot({
    req(subset_data())
    ggplot(subset_data(), aes_string(x = input$xvar, y = input$yvar)) +
      geom_point()
  })
  
  # Summary of selected variables
  output$summary <- renderPrint({
    req(subset_data())
    summary(subset_data())
  })
}

# Run the app -------------------------------------------------------
shinyApp(ui, server)
