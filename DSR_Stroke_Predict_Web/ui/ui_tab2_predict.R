ui_tab2 <- fluidRow(
  column(
    width = 12,
    h3("Stroke Risk Prediction"),
    br(),
    
    # ---- Risk summary section ----
    fluidRow(
      column(6, gaugeOutput("risk_gauge")),
      column(6, htmlOutput("risk_text"))
    ),
    br(), hr(),
    
    # ---- Model results ----
    h4("Prediction Results by Model"),
    fluidRow(
      column(6, tableOutput("pred_table")),
      column(6, plotOutput("pred_bar", height = "250px"))
    )
  )
)
