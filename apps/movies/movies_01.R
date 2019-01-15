library(shiny)
library(ggplot2)
load("movies.Rdata")
library(DT)

# Define UI for application that plots features of movies -----------
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions --------------
  sidebarLayout(
    
    # Inputs: Select variables to plot ------------------------------
    sidebarPanel(
      
      # Select variable for y-axis ----------------------------------
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                  selected = "audience_score"),
      
      # Select variable for x-axis ----------------------------------
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                  selected = "critics_score"),
      
      # Select variable for colour -------------------
      selectInput(inputId = "z", 
                  label = "Colour By:",
                  choices = c("title_type",
                              "genre",
                              "mpaa_rating",
                              "critics_rating",
                              "audience_rating"
                              ),
                  selected = "mpaa_rating"),
      
      # Slider input for the transparency of the points
      sliderInput(inputId = "alpha",
                  label = "Transparency Adjust:",
                  min = 0, 
                  max = 1, 
                  value = 0.8, 
                  animate = TRUE),
      
      #Checkbox to show plotted data i data table instead
      checkboxInput(inputId = "DTcheck",
                    label = "Display as table?", 
                    value = FALSE
                    )
    ),
    
    # Output: Show scatterplot --------------------------------------
    mainPanel(
      
      uiOutput(outputId = "variableoutput")
      
    )
  )
)

# Define server function required to create the scatterplot ---------
server <- function(input, output) {

  # Create scatterplot object the plotOutput function is expecting --
  output$variableoutput <- renderUI({
    if(input$DTcheck){
      dataTableOutput({
        DT::datatable(data = movies[, 1:7], 
                    options = list(pageLength = 10), 
                    rownames = FALSE)
      })
    }else{plotOutput({
      ggplot(data = movies, aes_string(x = input$x, y = input$y, colour = input$z)) +
        geom_point(alpha = input$alpha)
      })
    }
  })
}

# Run the application -----------------------------------------------
shinyApp(ui = ui, server = server)

