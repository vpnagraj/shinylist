# shinylist

## Summary

shinylist is an [htmlwidget](http://htmlwidgets.org) for generating HTML lists from R output. The package includes a `shinylist()` function that uses custom JavaScript to parse a vector and output each element as a list item. This is particularly of use in the context of [Shiny](http://shiny.rstudio.com/) app development. The `renderList()` and `listOutput()` can be used respectively in the `server` and `ui` Shiny components.  

## Installation
```
devtools::install_github("vpnagraj/shinylist")
```
## Usage

From the R console, create an HTML list by passing a vector (either character or numeric) to  the `shinylist()` function: 

```
library(shinylist)
shinylist(mtcars$mpg)
shinylist(rownames(mtcars), ordered = TRUE)
```

For use within a Shiny app, include a call to `shinylist()` inside of a `renderList()` function that has a corresponding `listOutput()` element:

```
library(shiny)
library(shinylist)
library(dplyr)
library(ggplot2movies)

movies <-
    movies %>%
    filter(!is.na(budget))

server <- function(input, output) {
    
    output$movietitles<- renderList({
        
            dat <-
                movies %>%
                filter(budget >= input$budget) %>%
                arrange(desc(rating)) %>%
                select(title) 
            
            shinylist(dat$title)
        
    })
    
}

ui <- fluidPage(titlePanel("Movie Budgets > $100,000,000"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(
                inputId = "budget", 
                label = "Budget", 
                min = 100e6, 
                max = max(movies$budget), 
                value = 100e6,
                animate =  animationOptions(interval= 500))
        ),
        mainPanel(
            listOutput("movietitles")
        )
    )
)

shinyApp(ui = ui, server = server)
``` 

