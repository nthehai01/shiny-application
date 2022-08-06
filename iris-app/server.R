#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # Check if the user choose at least 2 features of the Iris to perform EDA
    output$warning <- renderText({
        count <- ifelse(input$show_sepal_length, 1, 0)
        count <- count + ifelse(input$show_sepal_width, 1, 0)
        count <- count + ifelse(input$show_petal_length, 1, 0)
        count <- count + ifelse(input$show_petal_width, 1, 0)
        
        ifelse(count > 1, "", "You must select at least 2 features of the Iris to make the Pairplot.")
    })
    
    # Plotting
    output$pairplot <- renderPlotly({
        data("iris")
        
        dimensions = list()
        if (input$show_sepal_length) 
            dimensions <- append(dimensions, list(list(label='Sepal Length', values=~Sepal.Length)))
        if (input$show_sepal_width)
            dimensions <- append(dimensions, list(list(label='Sepal Width', values=~Sepal.Width)))
        if (input$show_petal_length)
            dimensions <- append(dimensions, list(list(label='petal length', values=~Petal.Length)))
        if (input$show_petal_width)
            dimensions <- append(dimensions, list(list(label='petal width', values=~Petal.Width)))
        
        # Return if the user did not choose at least 2 features
        if (length(dimensions) < 2) return(NULL)
        
        pl_colorscale=list(c(0.0, '#19d3f3'),
                           c(0.333, '#19d3f3'),
                           c(0.333, '#e763fa'),
                           c(0.666, '#e763fa'),
                           c(0.666, '#636efa'),
                           c(1, '#636efa'))
        
        axis = list(showline=FALSE,
                    zeroline=FALSE,
                    gridcolor='#ffff',
                    ticklen=4)
        
        fig <- iris %>%
            plot_ly(width = 500, height = 500) 
        fig <- fig %>%
            add_trace(
                type = 'splom',
                dimensions = dimensions,
                text=~class,
                marker = list(
                    color = as.integer(iris$class),
                    colorscale = pl_colorscale,
                    size = 7,
                    line = list(
                        width = 1,
                        color = 'rgb(230,230,230)'
                    )
                )
            ) 
        fig <- fig %>%
            layout(
                title= 'Iris Data set',
                hovermode='closest',
                dragmode= 'select',
                plot_bgcolor='rgba(240,240,240, 0.95)',
                xaxis=list(domain=NULL, showline=F, zeroline=F, gridcolor='#ffff', ticklen=4),
                yaxis=list(domain=NULL, showline=F, zeroline=F, gridcolor='#ffff', ticklen=4),
                xaxis2=axis,
                xaxis3=axis,
                xaxis4=axis,
                yaxis2=axis,
                yaxis3=axis,
                yaxis4=axis
            )
        fig <- fig %>% style(showupperhalf = F)
        
        fig
    })

})
