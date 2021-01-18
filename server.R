library(rjson)
source('graficos.R', encoding = 'UTF-8')
source('dataPostgres.R', encoding = 'UTF-8')


server <- function(input, output, session) {
  dataPostgres = getDataPostgres()
  output$plotPostgres <- renderPlot({
    if (input$selectpostgres == "1") {
      itemGraphics(dataPostgres, dataPostgres$peso_promedio, "Peso")
    } else if (input$selectpostgres == "2") {
      itemGraphics(dataPostgres, dataPostgres$espesor, "Espesor")
    } else if (input$selectpostgres == "3") {
      itemGraphics(dataPostgres, dataPostgres$longitud, "Longitud")
    } else if (input$selectpostgres == "4") {
      itemGraphics(dataPostgres, dataPostgres$ancho, "Ancho")
    }
  })
  
  observeEvent(input$Json, {
    if (is.null(input$Json)) {
      showNotification("Json no seleccionado")
    }
    file <- input$Json
    ext <- tools::file_ext(file$datapath)
    req(file)
    validate(need(ext == "json", "Por favor, seleccione un archivo con JSON"))
    dataJSON = as.data.frame(fromJSON(file = input$Json$datapath))
    
    # Can also set the label and select items
    updateSelectInput(
      session,
      "selectjson",
      choices = names(dataJSON),
      selected = tail(names(dataJSON), 1)
    )
  }, ignoreInit = TRUE, ignoreNULL = FALSE)
  
  observeEvent(input$selectjson,
               {
                 if (is.null(input$selectjson)) {
                   showNotification("Json no seleccionado")
                 }
                 dataJSON = as.data.frame(fromJSON(file = input$Json$datapath))
                 output$plotJSON <- renderPlot({
                   itemGraphics(dataJSON, as.numeric(unlist(dataPostgres[input$selectjson])), input$selectjson)
                 })
               },
               ignoreInit = TRUE,
               ignoreNULL = FALSE)
  
}
