library(shiny)
source('ui.R', encoding = 'UTF-8')
source('server.R', encoding = 'UTF-8')

# Run the application 
if (interactive()) {
    shinyApp(ui = ui, server = server)
}
