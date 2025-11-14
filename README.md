# Stroke Prediction System

This repository provides a complete end-to-end system for stroke risk prediction, combining:

- Data preprocessing and model training (Python)
- A deployed machine learning inference API (Render)
- A deployed interactive web interface (R Shiny)
- Model evaluation visualizations and assets

Both the API and the Shiny application are fully deployed and connected.

---

## 🌐 Live Deployments

### 🔹 1. **Stroke Prediction API (Python — Render)**  
This REST API performs model inference and returns predicted stroke risk and probability.

**Live endpoint:**  
https://python-predict-api.onrender.com/predict

**Example POST request:**
```json
{
  "gender": "Male",
  "age": 67,
  "hypertension": 1,
  "heart_disease": 0,
  "avg_glucose_level": 136.41,
  "bmi": 28.1,
  "smoking_status": "formerly smoked"
}
````

**Example response:**

```json
{
  "prediction": 1,
  "probability": 0.84
}
```

---

### 🔹 2. **Stroke Prediction Web Application (R Shiny)**

Provides data visualization, model comparison, and an interactive prediction form.

**Live Web App:**
[https://thotmse190999.shinyapps.io/dsr_strokke_predict_web/](https://thotmse190999.shinyapps.io/dsr_strokke_predict_web/)

---

## ⚠️ Important System Behavior

The Shiny application (specifically **Tab 2: Prediction**) depends on the Render API being active.

### 💡 Because Render free tier sleeps after inactivity:

* The API becomes temporarily unavailable
* Shiny cannot fetch predictions until the API wakes up

### 👉 Correct usage:

1. Open the Render API first:
   [https://python-predict-api.onrender.com/](https://python-predict-api.onrender.com/)

2. Wait ~15–30 seconds for the server to wake up

3. Then open the Shiny App:
   [https://thotmse190999.shinyapps.io/dsr_strokke_predict_web/](https://thotmse190999.shinyapps.io/dsr_strokke_predict_web/)

4. Tab 2 (Prediction) will now work normally

---

## 📁 Project Structure

```
stroke/
│
├── data/                     # Raw dataset (stroke.csv)
│
├── python_predict_api/       # Deployed inference API (Python)
│   ├── api.py                # API routes and handlers
│   ├── predict_model.py      # Preprocessing + model loading
│   ├── models/               # Trained ML models (cloudpickle)
│   ├── train/                # Jupyter training notebooks
│   └── requirements.txt
│
├── DSR_Stroke_Predict_Web/   # Shiny application (R)
│   ├── ui/                   # UI components
│   ├── server/               # Server-side computation
│   ├── data/                 # Cleaned or prepared data
│   ├── www/                  # Visual assets (ROC, CM, importance)
│   └── app.R
│
└── README.md
```

---

## 🧠 Machine Learning Models

Trained models include:

* Logistic Regression
* Support Vector Machine (SVM)
* XGBoost

Each model is exported using **cloudpickle**, including its full preprocessing pipeline (encoding + scaling).

Stored in:

```
python_predict_api/models/
```

---

## 🔍 Training Pipeline

Training notebooks located in:

```
python_predict_api/train/
```

Contain:

* Data cleaning
* Exploratory analysis
* Feature transformation
* Training (Logistic, SVM, XGBoost)
* Performance evaluation (ROC, AUC, F1)
* Model export into `.pkl` pipelines

---

## 🧱 Technologies Used

* **Python** (scikit-learn, pandas, cloudpickle, FastAPI/Uvicorn)
* **R Shiny** (UI + Server)
* **Jupyter Notebook**
* **Render** (API hosting)
* **ShinyApps.io** (UI hosting)
* **Git + GitHub**

---

## ✨ Author

**Tran Minh Tho**
Email: [tranminhtho100@gmail.com](mailto:tranminhtho100@gmail.com)
GitHub: [https://github.com/TranTho918](https://github.com/TranTho918)
