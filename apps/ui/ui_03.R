library(shiny)

# Define UI for YouTube player --------------------------------------
# Won't render properly in preview windo
ui <- fluidPage(
  # inludeHTML("youtube_thumbnail.html")
      div(class="thumbnail",
               div(class="embed-responsive embed-responsive-16by9",
                   tags$iframe(class="embed-responsive-item",
                          src="http://www.youtube.com/embed/LqPko6a3Wh4",
                          `allowfullscreen` = NA)
               ),
               div(class="caption",
                   h3("You are technically correct"),
                   div("The best kind of correct!")
               )
    )
  
)

# Define server logic -----------------------------------------------
server <- function(input, output, session) {
  
}

# Run the app -------------------------------------------------------
shinyApp(ui, server)

