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
* 