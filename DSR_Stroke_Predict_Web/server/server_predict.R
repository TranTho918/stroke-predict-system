observeEvent(input$run_model, {
  # 1️⃣ Collect user input
  input_list <- list(
    age = input$age,
    hypertension = as.integer(input$hypertension),
    heart_disease = as.integer(input$heart_disease),
    ever_married = as.integer(input$ever_married),
    work_type = input$work_type,
    avg_glucose_level = input$avg_glucose_level,
    bmi = input$bmi,
    smoking_status = input$smoking_status
  )

  # 2️⃣ Call Flask API via predict_func()
  preds <- predict_func(input_list)

  # 🧩 Check if API returned result successfully
  if (is.null(preds)) {
    showNotification("⚠️ Unable to get prediction from API. Please check your internet or Flask service.", type = "error")
    return(NULL)
  }

  # Ensure numeric output
  preds <- lapply(preds, as.numeric)

  # 3️⃣ Compute ensemble probability (weighted average)
  ensemble_proba <- (0.3 * preds$logistic) + 
                    (0.2 * preds$svm) + 
                    (0.5 * preds$xgboost)

  # Convert probabilities to %
  prob_df <- data.frame(
    Model = c("Logistic Regression", "SVM", "XGBoost", "Ensemble"),
    Probability = round(c(preds$logistic, preds$svm, preds$xgboost, ensemble_proba) * 100, 1)
  )

  # 4️⃣ Display table and bar chart
  output$pred_table <- renderTable(prob_df, digits = 1)

  output$pred_bar <- renderPlot({
    ggplot(prob_df, aes(x = Model, y = Probability, fill = Model)) +
      geom_col(width = 0.6) +
      geom_text(aes(label = paste0(Probability, "%")),
                vjust = -0.3, size = 4) +
      scale_fill_manual(values = c(
        "Logistic Regression" = "#6FCF97",  # green
        "SVM" = "#F2C94C",                  # yellow
        "XGBoost" = "#F2994A",              # orange
        "Ensemble" = "#EB5757"              # red
      )) +
      ylim(0, 100) +
      theme_minimal(base_size = 13) +
      theme(legend.position = "none") +
      labs(title = "Stroke Risk Probability by Model",
           y = "Predicted Probability (%)", x = NULL)
  })

  # 5️⃣ Risk gauge based on ensemble probability
  risk_val <- round(ensemble_proba * 100)
  risk_level <- ifelse(risk_val >= 80, "Very High",
                       ifelse(risk_val >= 60, "High",
                              ifelse(risk_val >= 40, "Moderate",
                                     ifelse(risk_val >= 20, "Low", "Very Low"))))

  output$risk_gauge <- flexdashboard::renderGauge({
    flexdashboard::gauge(
      value = risk_val,
      min = 0, max = 100,
      label = paste0(risk_val, "%"),
      sectors = flexdashboard::gaugeSectors(
        success = c(0, 20),   # green zone
        warning = c(20, 40),  # yellow-orange zone
        danger  = c(40, 100)  # red zone
      )
    )
  })

  # 6️⃣ Text interpretation
  output$risk_text <- renderText({
    glue::glue(
      "Your estimated stroke risk (ensemble model) is <b>{risk_val}%</b> (<b>{risk_level}</b>).<br><br>
       This prediction is considered <b>moderately reliable</b> — the model correctly identified most real stroke cases,
       but sometimes gives false alarms for people who are actually healthy.<br><br>
       If your risk is <b>below 20%</b>, it is generally considered safe.<br>
       Between <b>20–30%</b>, you should maintain healthy habits and monitor your condition.<br>
       If your risk is <b>above 30%</b>, it is <b>strongly recommended to consult a doctor</b> 
       for a professional medical assessment."
    )
  })
})
