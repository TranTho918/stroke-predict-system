# =====================================================
# GLOBAL.R — Global configuration for Stroke Shiny App
# =====================================================

library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(httr)
library(jsonlite)
library(flexdashboard)

# ---- 1. Load cleaned dataset ----
stroke_df <- suppressMessages(
  read_csv("data/stroke_cleaned.csv", show_col_types = FALSE)
) |> rename_with(tolower)

# ---- 2. Helper function: compute stroke rate ----
compute_stroke_rate <- function(df, group_var) {
  df |>
    group_by({{ group_var }}) |>
    summarise(stroke_rate = mean(stroke, na.rm = TRUE)) |>
    ungroup()
}

# ---- 3. Predict via Flask API on Render ----
# ⚠️ Thay URL bên dưới bằng API thật của bạn (ví dụ: https://python-predict-api.onrender.com/predict)
API_URL <- "https://python-predict-api.onrender.com/predict"

predict_func <- function(input_list) {
  # Gửi request tới Flask API
  res <- tryCatch({
    POST(
      url = API_URL,
      body = input_list,
      encode = "json",
      timeout(10)
    )
  }, error = function(e) {
    warning("⚠️ Cannot connect to Flask API: ", e$message)
    return(NULL)
  })

  # Xử lý kết quả
  if (is.null(res)) return(NULL)
  if (res$status_code != 200) {
    warning("⚠️ API error, status code: ", res$status_code)
    return(NULL)
  }

  result <- content(res, as = "parsed", type = "application/json")

  # Trả về kết quả dự đoán
  if (!is.null(result$result)) {
    return(result$result)
  } else {
    warning("⚠️ Unexpected API response format.")
    return(NULL)
  }
}
