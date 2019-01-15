ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      helpText("Placeholder")
    ),
    mainPanel(
      uiOutput("moreControls")
    )
  )

)

server <- function(input, output) {
  output$moreControls <- renderUI({
    tagList(
      sliderInput("n", "N", 1, 1000, 500),
      textInput("label", "Label")
    )
  })
}
shinyApp(ui, server)