library(shiny)
library(bslib)
library(DT)
library(plotly)

ui <- navbarPage(
  title = "Dane Energetyczne PSE",
  theme = bs_theme(version = 4, bootswatch = "flatly"),
  
  # Zakładka wyboru danych
  tabPanel(
    "Tabela danych",
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "data_type",
          "Wybierz typ danych:",
          choices = list(
            "Ceny" = "ceny",
            "PV" = "pv",
            "Wiatr" = "wiatr",
            "Magazyny Energii" = "sumatyczna_moc_ladowania_magazynow_energii",
            "Zapotrzebowanie" = "zapotrzebowanie_na_moc"
          )
        ),
        dateRangeInput(
          "date_range",
          "Zakres dat:",
          start = "2024-06-14",
          end = Sys.Date()
        ),
        tags$p("Aby zaktualizować zakres dat, wciśnij poniższy przycisk : ).", style = "color: red; font-weight: bold;"),
        actionButton("update_data", "Aktualizuj dane")
      ),
      mainPanel(
        DTOutput("data_table")
      )
    )
  ),
  
  # Zakładka wizualizacji czasowej
  tabPanel(
    "Wykres czasowy",
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "time_series_data",
          "Wybierz typ danych:",
          choices = list(
            "Ceny" = "ceny",
            "PV" = "pv",
            "Wiatr" = "wiatr",
            "Magazyny Energii" = "sumatyczna_moc_ladowania_magazynow_energii",
            "Zapotrzebowanie" = "zapotrzebowanie_na_moc"
          )
        )
      ),
      mainPanel(
        plotlyOutput("time_series_plot")
      )
    )
  ),
  
  # Zakładka dodatkowej wizualizacji
  tabPanel(
    "Dodatkowa wizualizacja",
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "extra_data",
          "Wybierz typ danych:",
          choices = list(
            "Ceny" = "ceny",
            "PV" = "pv",
            "Wiatr" = "wiatr",
            "Magazyny Energii" = "sumatyczna_moc_ladowania_magazynow_energii",
            "Zapotrzebowanie" = "zapotrzebowanie_na_moc"
          )
        )
      ),
      mainPanel(
        plotlyOutput("extra_visualization")
      )
    )
  )
)
