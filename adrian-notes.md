# Notes
## Day 1
### Intro slides

When would using a two file shiny structure be more appropriate than using app.R?
* 

#### Basics again
UI/Server function names are conventions but don't have to be named that

First argument to render functions is all the code needed to create the object contained within the curly braces. 

Movies_04.R has the answer to the DT exercise. DT:: version of render has more options 
* Issue here with trying to display two different outputs (dt and plot) in the same position as renderUI
* Probably not the way to do it...

#### File structure
global.R (datasets, helper functions, etc) can be included if using a two-file system

### Reactive Programming
#### Reactivity 101
Monitored input values cause outputs to be updated as they change: invalidates current values, updates dependent variables.
Started using movies_05.R 

#### Reactive objects
Source: Input from user (slider, select, checkbox, etc)
Conductor: 
* Flow control situated between inputs and outputs
* Modify input values and pass to multiple outputs
Endpoint: Output to browser window (plot, table, etc)

#### Reactive functions (conductors)
* Cached expressions that recognize when their output is out of date and re-runs
* Return a value
* Lazy response: only executed when it is called by one of its dependents
* Name them using verbs as a convention  
```name <- reactive({expression})```  
eg. ``` get_data <- reactive({movies[input$selection]})```
* Used in place of data:  
eg ```ggplot(get_data(), aes())```
* Putting reactive functions in a separate file requires the flag local=TRUE when sourcing to ensure they run and react to the right environment
* Subsetting a reactive function that returns a table/vector can be done with [] as if it were a simple dataset
* Reactive values (the result of a reactive function) must be used in a reactive context (eg. in a render* function). Shiny error of "Operation not allowed without an active reactive context"
* movies_07.R
* Side effects include: drawing a plot, saving a file, etc... Anything that isn't returning a value
* reactiveValues(): creates a reactive list, any elements thereof become reactive themselves and if changed any reference to that value will be changed later on. Must be used in a reactive context  
```
rv <- reactiveValue(x=10, y = "test")
paste("The value of x is:", rv$x, "and y contains:", rv$y)
# Fake render: The value of x is: 10 and y contains: test

rv$x <- 20
rv$y <- "another phrase"
rv$z <- "a new variable that becomes reactive"
# Fake render updates to the new results
```
*  Explanation of observe/reactive [here](https://stackoverflow.com/questions/39436713/r-shiny-reactivevalues-vs-reactive)

#### Observers and Side Effects:
* Does not return a value
* Used because of the side effects
* Eagerly respond to reactives: execute right away whenever one of its reactive dependencies changes even if that value is not needed immediately by any of its other dependencies.
* Good example of observer in movies_11.R line 116 running: ```updateNumericInput```

*Ex.*  
movies_12.R exercise: plot title changes don't result in changes to the sampled data. This is because the creation of that subsample doesn't rely on the plot title, only the n_samples value.

### Understanding UI

* Rows and columns using fluidRow() and then column()
* 12 columns per page
* withTags()
* includeHTML()
* backticks around nonstandard attribute names  
`attr` = value
* ui_03/4

### Advanced Reactivity
* Observers: side effects - counting, saving, making notes
* Reactives return cached values unless something changes. Functions run each time
* observeEvent() - ignores reverse dependencies and only relies on changes in the first argument
* eventReactive(EVENTTOOBSERVE) - EVENT can be a c() vector of inputs to monitor! "OR": see cranlogs.R
* Added a jquery setup to run the update button on pressing enter in cranlogs-enterpress.R Added the same functionality to cranlogs.R


## Day 2

### Advanced reactivity 2
Isolate: enforces that the isolated reactive variables retain their original values and don't update.

#### Checking preconditions
* validate() and need() - allow feedback to errors
* Truthy - 
* Input variable can be list of lists
  * eg ```input$file$filepath```
* Dynamic.R has important demonstration of the importance of 

#### Timing
* invalidatelater(time in ms) - causes to rerun the reactive code regularly
* Pass a reactive to these functions with a pipe to rate limit:
  * debounce(x, ms) - prevents updating until a certain amount of time has passed 
  * throttle(x, ms) - prevents a reactive from updating more often than Xms
* points.R - debounce to update plot early then summarize later.
* shinySignals

### Modules
* Standalone shiny app pieces able to be connected together to make an app
* Reuse code instead of copying and pasting everywhere
* Can be bundled into packages
* Use the [shinymod](https://gist.github.com/jcheng5/c09a2449c0a94c8f498c4a68a416bc3b) [snippet](https://support.rstudio.com/hc/en-us/articles/204463668-Code-Snippets)
* UI:
  * Unique namespaces so variable names can be reused.
  * NS()
  * Prepend namespace to all inputs / output ids
  * ns(input$var), ns(output$var)
  * taglist(...) collects UI elements to pass back to the main app
  * Has it's own input/output values that aren't shared with the main app: why all the inputs must be passed to the module
* Server function
  * Does not require the ns() function
  * Treat inputs and outputs as normal
  * Add data inputs beyond UI after session
* Passing data into modules
 * Static values follow session in the call
 * Reactives:
   * pass in as a reference (no '()') to preserve reactivity
   * pass in a reactive input wrapped as a new reactive expression ```reactive(input$var)```
     * Use it as a new reactive expr: var()
* Returning data from a module 
 * This was blazed over and will have to be learned on your own.
* 

### Bookmarking
* Save state of application between sessions that can be shared between users: Not actually saving state but saving state of all the inputs
* The doBookmark() function takes an id as argument
* Ignoreinit in observe event

### Troubleshooting
* Read Later
* Common Errors:
  * 'object of type closure': Reactive called without 
  * unexpected symbol, argument etc - missing comma
  * Active reactive context - Tried to access an input or a reactive function from inside the server function not a reactive 

### Debugging Tools
* logjs - output messages to browser JS console
* browser() - jumps into R console and allows for examining variables etc
* Options:
  * shiny.trace=T - logs messages from shiny app
  * shiny.fullstacktrace - gives full errors
* Automatic testing isn't really possible: write components outside Shiny and then importing after helps to prevent

### Dashboards
* shinydashboard
* flexdashboard: Rmd based

## Appendix
### Links
* [Datacamp course with reactivity](https://s3.amazonaws.com/assets.datacamp.com/production/course_4850/slides/Chapter3.pdf)
* [Databases](https://db.rstudio.com/dplyr/)
* [Crosstalk](https://rstudio.github.io/crosstalk/)
* [Profiling Apps](https://shiny.rstudio.com/articles/profiling.html)
* 


### Ideas to Run With
* brushedPoints() - selected points on a plot
* miniUI
* shinyjs - alerts/popups etc... JS functionality in shiny
* Shiny BS/toastr/dashboard/themes
* See movies_12.R for how to add theme selector widget in a permanent way to the app
* reactiveFileReader / reactivePoll