library(shiny)
library(data.table)
library(plotly)
source("utils.r")

server <- function(input, output, session) {
  
  # Pobieranie danych
  fetch_data <- reactive({
    req(input$date_range)
    dates <- seq(as.Date(input$date_range[1]), as.Date(input$date_range[2]), by = "day")
    
    if (input$data_type == "ceny") {
      return(rbindlist(lapply(dates, get_CENY_ROZL)))
    } else {
      data <- rbindlist(lapply(dates, get_HIS_WLK_CAL), fill = TRUE)
      if (!(input$data_type %in% colnames(data))) {
        stop("Wybrana kolumna nie istnieje w danych.")
      }
      return(data[, c("timestamp", input$data_type), with = FALSE])
    }
  })
  
  # Renderowanie tabeli
  output$data_table <- renderDT({
    datatable(fetch_data(), options = list(pageLength = 10))
  })
  
  # Wykres czasowy
  time_series_data <- reactive({
    req(input$time_series_data, input$date_range)
    dates <- seq(as.Date(input$date_range[1]), as.Date(input$date_range[2]), by = "day")
    
    if (input$time_series_data == "ceny") {
      return(rbindlist(lapply(dates, get_CENY_ROZL)))
    } else {
      data <- rbindlist(lapply(dates, get_HIS_WLK_CAL), fill = TRUE)
      if (!(input$time_series_data %in% colnames(data))) {
        stop("Wybrana kolumna nie istnieje w danych.")
      }
      return(data[, c("timestamp", input$time_series_data), with = FALSE])
    }
  })
  
  output$time_series_plot <- renderPlotly({
    data <- time_series_data()
    plot_ly(data, 
            x = ~timestamp, 
            y = as.formula(paste("~", colnames(data)[2])), 
            type = 'scatter', 
            mode = 'lines') %>%
      layout(
        xaxis = list(title = "Czas"),
        yaxis = list(title = colnames(data)[2])
      )
  })
  
  # Dodatkowa wizualizacja
  extra_data <- reactive({
    req(input$extra_data, input$date_range)
    dates <- seq(as.Date(input$date_range[1]), as.Date(input$date_range[2]), by = "day")
    
    if (input$extra_data == "ceny") {
      return(rbindlist(lapply(dates, get_CENY_ROZL)))
    } else {
      data <- rbindlist(lapply(dates, get_HIS_WLK_CAL), fill = TRUE)
      if (!(input$extra_data %in% colnames(data))) {
        stop("Wybrana kolumna nie istnieje w danych.")
      }
      return(data[, c("timestamp", input$extra_data), with = FALSE])
    }
  })
  
  output$extra_visualization <- renderPlotly({
    data <- extra_data()
    plot_ly(data, 
            x = as.formula(paste("~", colnames(data)[2])), 
            type = 'histogram') %>%
      layout(
        xaxis = list(title = colnames(data)[2]),
        yaxis = list(title = "Częstotliwość")
      )
  })
}
