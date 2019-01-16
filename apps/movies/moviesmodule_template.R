# Module UI ---------------------------------------------------------
movies_module_UI <- function(id) {
  ns <- NS(id)
  
  tagList(
    ### add UI elements ###
    plotOutput(ns("scatterplot")),
    DT::dataTableOutput(ns("moviestable"))
  )
  
}

# Module server -----------------------------------------------------
movies_module <- function(input, output, session, movies, title_type, alpha, size, x, y, z, show_data) {
  
  # Select movies with given title type -----------------------------
  ### add UI elements ###
  subset_data <- reactive({
    filter(movies, title_type == as.character(title_type)) # Test if the as.character is actually necessary
  })
  
  # Create scatterplot object the plotOutput function is expecting --
  ### add plotting code ###
  output$scatterplot <- renderPlot({
    ggplot(data = subset_data(), aes_string(x = x(), y = y(), color = z())) +
      geom_point(alpha = alpha(), size = size()) +
      labs(x = toTitleCase(str_replace_all(x(), "_", " ")),
           y = toTitleCase(str_replace_all(y(), "_", " ")),
           color = toTitleCase(str_replace_all(z(), "_", " "))
      )
  })
  
  # Print data table if checked -------------------------------------
  ### add data table code ###
  output$moviestable <- DT::renderDataTable(
    if(show_data()){
      DT::datatable(data = subset_data()[, 1:7], 
                    options = list(pageLength = 10), 
                    rownames = FALSE)
    }
  )
}