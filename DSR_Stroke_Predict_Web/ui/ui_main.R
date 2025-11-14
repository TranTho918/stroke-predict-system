library(shiny)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  tags$script("
    Shiny.addCustomMessageHandler('clickButton', function(data) {
      var btn = document.getElementById(data.id);
      if (btn) btn.click();
    });
  "),
  titlePanel("Stroke Risk Prediction Dashboard"),
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age", 20, 0, 100),
      numericInput("avg_glucose_level", "Glucose Level", 100, 50, 300),
      numericInput("bmi", "BMI", 20, 10, 60),
      selectInput("hypertension", "Hypertension", c("No" = 0, "Yes" = 1)),
      selectInput("heart_disease", "Heart Disease", c("No" = 0, "Yes" = 1)),
      selectInput("ever_married", "Ever Married", c("No" = 0, "Yes" = 1)),
      selectInput("work_type", "Work Type",
                  c("Private", "Self-employed", "Govt_job", "Child_Neverwork")),
      selectInput("smoking_status", "Smoking Status",
                  c("never smoked", "formerly smoked", "smokes")),
      actionButton("run_model", "Visualize & Predict",
                   style = "background-color:#2F80ED; color:white; font-weight:bold;
                            padding:10px 25px; border-radius:8px; border:none; width:100%;"),
      hidden(actionButton("run", "Show"))
    ),
    mainPanel(
      tabsetPanel(
        id = "main_tabs",
        tabPanel("Visualization", source("ui/ui_tab1_visual.R", local = TRUE)$value),
        tabPanel("Prediction", source("ui/ui_tab2_predict.R", local = TRUE)$value),
        tabPanel("Models Evaluation", source("ui/ui_tab3_future.R", local = TRUE)$value)
      )
    )
  )
)
