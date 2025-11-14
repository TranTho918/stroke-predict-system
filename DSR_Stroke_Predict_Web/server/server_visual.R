observeEvent(input$show_tab1, {
  updateTabsetPanel(session, "main_tabs", selected = "Visualization")
})

plot_continuous <- function(data, xvar, input_value = NULL, xlab = NULL, title = NULL) {
  df_line <- data %>%
    mutate(bin = cut(get(xvar), breaks = 15)) %>%
    group_by(bin) %>%
    summarize(
      x_mid = mean(range(get(xvar), na.rm = TRUE)),
      stroke_rate = mean(stroke, na.rm = TRUE) 
    ) %>%
    mutate(stroke_rate = stroke_rate * 100) 

  p <- ggplot(df_line, aes(x = x_mid, y = stroke_rate)) +
    geom_line(color = "steelblue", linewidth = 1.3) +
    geom_point(color = "darkorange", size = 3) +
    labs(
      title = title,
      x = xlab,
      y = "Stroke Rate (%)"
    ) +
    theme_minimal(base_size = 16) +
    theme(
      plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
      axis.title = element_text(face = "bold"),
      axis.text = element_text(size = 13)
    )

  if (!is.null(input_value)) {
    closest_y <- df_line$stroke_rate[which.min(abs(df_line$x_mid - input_value))]
    p <- p +
      annotate("point", x = input_value, y = closest_y, color = "red", size = 5) +
      labs(subtitle = "● Red dot = user input value") +
      theme(plot.subtitle = element_text(color = "red", face = "italic", size = 13, hjust = 0.5))
  }
  p
}

plot_categorical <- function(df, varname, input_value = NULL, xlab = NULL, title = NULL) {
  if (varname %in% c("ever_married", "hypertension", "heart_disease")) {
    df[[varname]] <- ifelse(df[[varname]] == 1, "Yes", "No")
    if (!is.null(input_value)) input_value <- ifelse(input_value == 1, "Yes", "No")
  }

  df_plot <- df %>%
    group_by(!!sym(varname)) %>%
    summarise(stroke_rate = mean(stroke, na.rm = TRUE)) %>%
    mutate(stroke_rate = stroke_rate * 100)

  if (is.null(input_value)) {
    p <- ggplot(df_plot, aes_string(x = varname, y = "stroke_rate")) +
      geom_col(width = 0.6, fill = "steelblue")
  } else {
    df_plot <- df_plot %>%
      mutate(highlight = ifelse(as.character(!!sym(varname)) == as.character(input_value), "User", "Other"))
    p <- ggplot(df_plot, aes_string(x = varname, y = "stroke_rate", fill = "highlight")) +
      geom_col(width = 0.6) +
      scale_fill_manual(values = c("User" = "#ff3b3b", "Other" = "gray80"))
  }

  p +
    labs(
      title = title,
      x = xlab,
      y = "Stroke Rate (%)",
      subtitle = "■ Red bar = user input value"
    ) +
    theme_minimal(base_size = 16) +
    theme(
      legend.position = "none",
      plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
      plot.subtitle = element_text(color = "red", face = "italic", size = 13, hjust = 0.5),
      axis.title = element_text(face = "bold"),
      axis.text.x = element_text(size = 12, face = "bold"),
      axis.text.y = element_text(size = 12)
    )
}

output$plot_age <- renderPlot(plot_continuous(stroke_df, "age", input$age, "Age", "Effect of Age on Stroke Rate"))
output$plot_glucose <- renderPlot(plot_continuous(stroke_df, "avg_glucose_level", input$avg_glucose_level, "Average Glucose Level", "Effect of Glucose Level on Stroke Rate"))
output$plot_bmi <- renderPlot(plot_continuous(stroke_df, "bmi", input$bmi, "BMI", "Effect of BMI on Stroke Rate"))
output$plot_work <- renderPlot(plot_categorical(stroke_df, "work_type", input$work_type, "Work Type", "Stroke Rate by Work Type"))
output$plot_married <- renderPlot(plot_categorical(stroke_df, "ever_married", input$ever_married, "Marital Status", "Stroke Rate by Marital Status"))
output$plot_smoke <- renderPlot(plot_categorical(stroke_df, "smoking_status", input$smoking_status, "Smoking Status", "Stroke Rate by Smoking Status"))
output$plot_hyper <- renderPlot(plot_categorical(stroke_df, "hypertension", input$hypertension, "Hypertension", "Stroke Rate by Hypertension"))
output$plot_heart <- renderPlot(plot_categorical(stroke_df, "heart_disease", input$heart_disease, "Heart Disease", "Stroke Rate by Heart Disease"))
