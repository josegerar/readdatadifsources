library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Lectura de datos"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Datos Postgres", tabName = "postgres", icon = icon("bar-chart")),
      menuItem("Datos JSON", tabName = "json", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(
        tabName = "postgres",
        h2("Lectura de datos Postgres"),
        selectInput(
          inputId = 'selectpostgres',
          label = "Seleccione una variable a mostrar",
          choices = list("Peso" = 1, "Espesor" = 2, "Longitud" = 3, "Ancho" = 4)
        ),
        plotOutput("plotPostgres")
      ),
      # Second tab content
      tabItem(
        tabName = "json",
        h2("Lectura de datos JSON"),
        fileInput(
          "Json", 
          "Seleccione el archivo Json a leer",
          multiple = FALSE,
          accept = c(".json")
        ),
        selectInput(
          inputId = 'selectjson',
          label = "Seleccione una variable a mostrar",
          choices = c("Seleccione")
        ),
        plotOutput("plotJSON")
      )
    )
  )
)