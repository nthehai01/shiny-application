#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(

    titlePanel("Iris EDA"),

    sidebarLayout(
        sidebarPanel(
            checkboxInput("show_sepal_length", "Show/Hide Sepal Length", value = TRUE),
            checkboxInput("show_sepal_width", "Show/Hide Sepal Width", value = TRUE),
            checkboxInput("show_petal_length", "Show/Hide Petal Length", value = TRUE),
            checkboxInput("show_petal_width", "Show/Hide Petal Width", value = TRUE)
        ),

        mainPanel(
            textOutput("warning"),
            plotlyOutput("pairplot")
        )
    )
))
