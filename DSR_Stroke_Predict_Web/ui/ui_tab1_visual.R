ui_tab1 <- fluidRow(
  h4("Data Visualization"),
  plotOutput("plot_age"),
  plotOutput("plot_glucose"),
  plotOutput("plot_bmi"),
  plotOutput("plot_work"),
  plotOutput("plot_married"),
  plotOutput("plot_smoke"),
  plotOutput("plot_hyper"),
  plotOutput("plot_heart")
)
