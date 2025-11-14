ui_tab3 <- fluidRow(

  h2("Model Explainability & Comparison", align = "left", style = "margin-bottom:5px;"),
  p("This tab provides extended analysis of model interpretability, visual comparisons, and detailed performance insights for Logistic Regression, SVM, and XGBoost models.",
    align = "left", style = "font-size:15px; margin-top:0px; margin-bottom:10px;"),
  hr(style = "margin-top:5px; margin-bottom:10px;"),

  fluidRow(
    column(4, h3("Logistic Regression", align = "center", style = "color:#6FCF97; font-weight:bold;")),
    column(4, h3("Support Vector Machine (SVM)", align = "center", style = "color:#F2C94C; font-weight:bold;")),
    column(4, h3("XGBoost", align = "center", style = "color:#F2994A; font-weight:bold;"))
  ),

  # === 1. Feature Importance ===
  h4("1. Feature Importance", align = "left", style = "font-weight:bold; margin-top:5px; margin-bottom:5px;"),
  fluidRow(
    column(4, div(style="text-align:center;", 
                  imageOutput("img_logistic_importance", height = "auto"),
                  p(textOutput("comment_logistic_importance"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_svm_importance", height = "auto"),
                  p(textOutput("comment_svm_importance"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_xgb_importance", height = "auto"),
                  p(textOutput("comment_xgb_importance"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;")))
  ),

  # === 2. Confusion Matrix ===
  h4("2. Confusion Matrix", align = "left", style = "font-weight:bold; margin-top:5px; margin-bottom:5px;"),
  fluidRow(
    column(4, div(style="text-align:center;", 
                  imageOutput("img_logistic_cm", height = "auto"),
                  p(textOutput("comment_logistic_cm"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_svm_cm", height = "auto"),
                  p(textOutput("comment_svm_cm"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_xgb_cm", height = "auto"),
                  p(textOutput("comment_xgb_cm"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;")))
  ),

  # === 3. Threshold Distribution ===
  h4("3. Threshold Distribution (Threshold = 0.3)", align = "left", style = "font-weight:bold; margin-top:5px; margin-bottom:5px;"),
  fluidRow(
    column(4, div(style="text-align:center;", 
                  imageOutput("img_logistic_thres", height = "auto"),
                  p(textOutput("comment_logistic_thres"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_svm_thres", height = "auto"),
                  p(textOutput("comment_svm_thres"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_xgb_thres", height = "auto"),
                  p(textOutput("comment_xgb_thres"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;")))
  ),

  # === 4. ROC Curve ===
  h4("4. ROC Curve & AUC", align = "left", style = "font-weight:bold; margin-top:5px; margin-bottom:5px;"),
  fluidRow(
    column(4, div(style="text-align:center;", 
                  imageOutput("img_logistic_roc", height = "auto"),
                  p(textOutput("comment_logistic_roc"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_svm_roc", height = "auto"),
                  p(textOutput("comment_svm_roc"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;"))),
    column(4, div(style="text-align:center;", 
                  imageOutput("img_xgb_roc", height = "auto"),
                  p(textOutput("comment_xgb_roc"),
                    style="font-size:13px; color:#555; font-style:italic; margin-top:15px; margin-bottom:25px;")))
  ),

  # === 5. Main Metrics & Key Insight (bạn yêu cầu) ===
  h4("5. Main Metrics & Key Insight", align = "left", style = "font-weight:bold; margin-top:10px; margin-bottom:5px;"),
  p("Summarized performance metrics and analytical insights for each model at threshold = 0.3.",
    align = "left", style = "font-style:italic; color:#555; margin-bottom:10px;"),

  fluidRow(
    column(
      4,
      div(
        style = "padding:10px; border:1px solid #ddd; border-radius:10px; background-color:#fafafa;",
        h5("Logistic Regression", align = "center", style="font-weight:bold; color:#6FCF97; margin-bottom:8px;"),
        uiOutput("table_logistic")
      )
    ),
    column(
      4,
      div(
        style = "padding:10px; border:1px solid #ddd; border-radius:10px; background-color:#fafafa;",
        h5("Support Vector Machine (SVM)", align = "center", style="font-weight:bold; color:#F2C94C; margin-bottom:8px;"),
        uiOutput("table_svm")
      )
    ),
    column(
      4,
      div(
        style = "padding:10px; border:1px solid #ddd; border-radius:10px; background-color:#fafafa;",
        h5("XGBoost", align = "center", style="font-weight:bold; color:#F2994A; margin-bottom:8px;"),
        uiOutput("table_xgb")
      )
    )
  )
)
