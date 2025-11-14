server <- function(input, output, session) {
  observe({
    invalidateLater(1000, session)
    isolate({
      if (is.null(input$run) || input$run == 0) {
        for (btn in c("show_tab1", "run_model", "run")) {
          session$sendCustomMessage("clickButton", list(id = btn))
        }
      }
    })
  })

  source("server/server_visual.R", local = TRUE)
  source("server/server_predict.R", local = TRUE)
  source("server/server_result.R", local = TRUE)
}
