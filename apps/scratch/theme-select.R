library(shiny)
library(shinythemes)

themeSelector <- function() {
  div(
    div(
      selectInput("shinytheme-selector", "Choose a theme",
                  c("default", shinythemes:::allThemes()),
                  selectize = FALSE
      )
    ),
    tags$script(
      "$('#shinytheme-selector')
      .on('change', function(el) {
      var allThemes = $(this).find('option').map(function() {
      if ($(this).val() === 'default')
      return 'bootstrap';
      else
      return $(this).val();
      });
      // Find the current theme
      var curTheme = el.target.value;
      if (curTheme === 'default') {
      curTheme = 'bootstrap';
      curThemePath = 'shared/bootstrap/css/bootstrap.min.css';
      } else {
      curThemePath = 'shinythemes/css/' + curTheme + '.min.css';
      }
      // Find the <link> element with that has the bootstrap.css
      var $link = $('link').filter(function() {
      var theme = $(this).attr('href');
      theme = theme.replace(/^.*\\//, '').replace(/(\\.min)?\\.css$/, '');
      return $.inArray(theme, allThemes) !== -1;
      });
      // Set it to the correct path
      $link.attr('href', curThemePath);
      });"
      )
    )
  }

ui <- fluidPage(
  fluidRow(
    column(4, themeSelector())
  )
)

server <- function(input, output) {
  
}

shinyApp(ui, server)