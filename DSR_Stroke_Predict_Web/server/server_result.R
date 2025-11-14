observeEvent(input$run, {

  json_path <- "www/model_image_comments.json"
  comments <- jsonlite::fromJSON(json_path)
  get_comment <- function(fname) {
    item <- comments[comments$filename == fname, ]
    if (nrow(item) > 0) return(item$comment) else return("")
  }

  output$img_logistic_importance <- renderImage({ list(src = "www/logistic_importance.png", width = "100%") }, deleteFile = FALSE)
  output$comment_logistic_importance <- renderText({ get_comment("logistic_importance.png") })

  output$img_logistic_cm <- renderImage({ list(src = "www/logistic_cm.png", width = "100%") }, deleteFile = FALSE)
  output$comment_logistic_cm <- renderText({ get_comment("logistic_cm.png") })

  output$img_logistic_thres <- renderImage({ list(src = "www/logistic_threshold.png", width = "100%") }, deleteFile = FALSE)
  output$comment_logistic_thres <- renderText({ get_comment("logistic_threshold.png") })

  output$img_logistic_roc <- renderImage({ list(src = "www/logistic_roc.png", width = "100%") }, deleteFile = FALSE)
  output$comment_logistic_roc <- renderText({ get_comment("logistic_roc.png") })


  output$img_svm_importance <- renderImage({ list(src = "www/svm_importance.png", width = "100%") }, deleteFile = FALSE)
  output$comment_svm_importance <- renderText({ get_comment("svm_importance.png") })

  output$img_svm_cm <- renderImage({ list(src = "www/svm_cm.png", width = "100%") }, deleteFile = FALSE)
  output$comment_svm_cm <- renderText({ get_comment("svm_cm.png") })

  output$img_svm_thres <- renderImage({ list(src = "www/svm_threshold.png", width = "100%") }, deleteFile = FALSE)
  output$comment_svm_thres <- renderText({ get_comment("svm_threshold.png") })

  output$img_svm_roc <- renderImage({ list(src = "www/svm_roc.png", width = "100%") }, deleteFile = FALSE)
  output$comment_svm_roc <- renderText({ get_comment("svm_roc.png") })


  output$img_xgb_importance <- renderImage({ list(src = "www/xgboost_importance.png", width = "100%") }, deleteFile = FALSE)
  output$comment_xgb_importance <- renderText({ get_comment("xgboost_importance.png") })

  output$img_xgb_cm <- renderImage({ list(src = "www/xgboost_cm.png", width = "100%") }, deleteFile = FALSE)
  output$comment_xgb_cm <- renderText({ get_comment("xgboost_cm.png") })

  output$img_xgb_thres <- renderImage({ list(src = "www/xgboost_threshold.png", width = "100%") }, deleteFile = FALSE)
  output$comment_xgb_thres <- renderText({ get_comment("xgboost_threshold.png") })

  output$img_xgb_roc <- renderImage({ list(src = "www/xgboost_roc.png", width = "100%") }, deleteFile = FALSE)
  output$comment_xgb_roc <- renderText({ get_comment("xgboost_roc.png") })


  make_html_table <- function(model_name, color, df) {
    df_t <- as.data.frame(t(df[, -1]))
    colnames(df_t) <- df$Class
    df_t <- tibble::rownames_to_column(df_t, "Metric")

    html <- paste0(
      '<div style="border:1px solid #ddd; border-radius:10px; background-color:#fafafa; padding:10px;">',
      '<table style="width:100%; border-collapse:collapse; text-align:center; font-size:14px;">',
      '<tr style="background-color:#f5f5f5;"><th>Metric</th><th>', colnames(df_t)[2], '</th><th>', colnames(df_t)[3], '</th></tr>'
    )
    for (i in 1:nrow(df_t)) {
      html <- paste0(html, '<tr>',
                     '<td style="padding:4px;">', df_t$Metric[i], '</td>',
                     '<td style="padding:4px;">', df_t[[2]][i], '</td>',
                     '<td style="padding:4px;">', df_t[[3]][i], '</td>',
                     '</tr>')
    }
    html <- paste0(html, '</table></div>')
    HTML(html)
  }

  output$table_logistic <- renderUI({
    df <- data.frame(
      Class = c("0 (No Stroke)", "1 (Stroke)"),
      Precision = c(0.99, 0.10),
      Recall = c(0.64, 0.88),
      F1 = c(0.78, 0.18),
      Meaning = c("Many false positives", "High detection, low precision")
    )
    make_html_table("Logistic Regression", "#6FCF97", df)
  })

  output$table_svm <- renderUI({
    df <- data.frame(
      Class = c("0 (No Stroke)", "1 (Stroke)"),
      Precision = c(0.99, 0.09),
      Recall = c(0.63, 0.79),
      F1 = c(0.77, 0.16),
      Meaning = c("Many false positives", "High detection, low precision")
    )
    make_html_table("Support Vector Machine (SVM)", "#F2C94C", df)
  })

  output$table_xgb <- renderUI({
    df <- data.frame(
      Class = c("0 (No Stroke)", "1 (Stroke)"),
      Precision = c(0.99, 0.11),
      Recall = c(0.72, 0.76),
      F1 = c(0.84, 0.19),
      Meaning = c("Balanced performance", "High recall, low precision")
    )
    make_html_table("XGBoost", "#F2994A", df)
  })

  updateTabsetPanel(session, "main_tabs", selected = "Explainability")
})
