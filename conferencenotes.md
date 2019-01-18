# Conf Notes Day 1

## Keynote: Shiny in Production - Joe Cheng

## Morning Talks

### Database connections with RStudio
Slides

* db.rstudio.com/overview
  * Many articles and best practices
* rstudio.community.com
* advanced programming with _purr_ and _rlang_ for db conection
* Google BigQuery Public Data for database practice: _bigrquery_
* Look into _tidyeval_

## Afternoon Talks

### QTL2 Re-write
[Slides](http://bit.ly/rstudio2019)
* kbroman.org/qtl2
* Quantitative Trail Loci (region of xsome that is affecting a certain trait)
* R-qtl identifies those genetic loci that affect certain traits
* Good things
  * Some code
  * UI
  * Comprehensive
  * Flexible
* Bad things
  * Not tidy data
  * Long input data load times
  * Baroque data structures
  * Inconsistensies
  * Useless warning messages
  * No tests
* Why?
  * Don't know any better
* Documentation
  * Tailored tutorials > User Guide > Examples > Formal documentation
* Fixes:
  * RCPP
  * Roxygen
  * Unit Tests

* Quotes:  
> "_Open source means everyone can see my stupid mistakes, version control means everyone can see every stupid mistake I've ever made._"  
"_I don't have tests: I have users._"  
-Karl Broman

>"_If you use software that lacks automated tests you are the tests._" - Jenny Bryan

>"_It's not that we don't test our code, it's that we don't keep our tests so they can be rerun._" - Hadley Wickham

### Getting it Right
Amanda Gadrow
Slides

* Code is a means to an end but is not temporary. It should be treated as the artifact it is and written thoughtfully and carefully.
* Good code:
  * Trust the outcome of analysis
  * Reliable (not brittle)
  * Reproducible
  * Flexible - incremental improvements
  * Longevity - straightforward to update in small bit size pieces
 * Scalability
* How to determine quality?
  * Execution feedback (console, etc)
  * User feedback
* Tests!
  * Functional
  * Integration
  * Performance
  * Start with major functions/inputs/integration points - most fragile points
  * Start with manual tests, conver to coded tests (unit tests) once basic functionality is established
  * Much easier to write tests while developing features
* Testthat
  * usethis::use_testthat() - creates directories
  * usethis::use_test("funcname") - creates tests
  * Expectations allow many tests beyond X == Y
  * Naming tests
* Dev workflow:
   1. Modify code
   2. Test ctrl+shift+T
   3. Repeat until all pass

 * Testing considerations slide
 * Hard to test == hard to maintain!
 * Shinytest for shiny apps
 * Good software practices
   * Good UX (including future you)
   * Good error handling
   * Modular design
     * Don't Repeat Yourself
     * KISS
* Consistent coding style
* github: [ajmcoqui](https://github.com/ajmcoqui)