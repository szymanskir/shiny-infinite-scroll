library(shiny)
library(magrittr)
library(waiter)

ui <- fluidPage(
  includeScript("www/app.js"),
  includeCSS("www/main.css"),
  useWaiter(),
  div(
    style = "
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    ",
    div(id = "end", style = " height: 242px; width: 384px")
  )
)

server <- function(input, output, session) {
  data_fetcher <- DataFetcher$new(api_url = "https://rickandmortyapi.com/api/character")
  current_page <- reactiveVal(1)
  
  initial_data <- data_fetcher$fetch_page(page_number = 1)$data
  initial_data_ui <- create_data_items(initial_data)
  insertUI(selector = "#end", where = "beforeBegin", ui = initial_data_ui)
  
  loader <- Waiter$new(id = "end", html = spin_3circles(), color = "hsl(210, 0%, 88%)")
  
  observeEvent(input$screen_end_reached, {
    loader$show()
    on.exit({
      loader$hide()
    })
    Sys.sleep(0.5)
    current_page(current_page() + 1)
    data <- data_fetcher$fetch_page(page_number = current_page())$data
    data_ui <- create_data_items(data)
    insertUI(selector = "#end", where = "beforeBegin", ui = data_ui)
  })
}

shinyApp(ui, server)