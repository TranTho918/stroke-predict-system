# Stroke Prediction System

This repository contains an end-to-end system for stroke risk prediction, including:
- Machine learning model training (Python)
- Model inference API (Python)
- Web application for visualization and prediction (Shiny R)
- Dataset and preprocessing pipeline

The project integrates data analysis, classification models, API deployment, and an interactive web UI.

---

## 📁 Project Structure

```

stroke/
│
├── data/                     # Dataset (stroke.csv)
│
├── python_predict_api/       # Python backend for model inference
│   ├── api.py                # REST API for prediction
│   ├── predict_model.py      # Load model + preprocessing
│   ├── models/               # Trained ML models (.pkl)
│   ├── train/                # Training notebooks
│   └── requirements.txt
│
├── DSR_Stroke_Predict_Web/   # Shiny web application
│   ├── ui/                   # UI definitions
│   ├── server/               # Server logic
│   ├── data/                 # Cleaned or processed data
│   ├── www/                  # Visualizations (ROC, CM, importance)
│   └── app.R
│
└── README.md

```

---

## 🧠 Machine Learning Models

Models trained:
- Logistic Regression
- Support Vector Machine (SVM)
- XGBoost

Models include preprocessing pipelines and are saved via **cloudpickle** in:

```

python_predict_api/models/

```

---

## 🔍 Training

All experiments and preprocessing steps are inside:

```

python_predict_api/train/

````

Training includes:
- Data cleaning
- Feature encoding & scaling
- Train/test split
- Model evaluation (ROC, F1, accuracy)
- Saving final pipelines

---

## 🔌 Python Prediction API

The API loads the trained pipeline and returns predictions from JSON input.

Run API:

```bash
cd python_predict_api
uvicorn api:app --reload
````

Example endpoint:

```
POST /predict
```

---

## 🌐 Shiny Web Application

Interactive web interface for:

* Data exploration
* User input form for prediction
* Model visualizations

Run:

```R
shiny::runApp("DSR_Stroke_Predict_Web")
```

---

## 📦 Installation

### Python

```
pip install -r python_predict_api/requirements.txt
```

### R (Shiny)

Install dependencies inside:

```
DSR_Stroke_Predict_Web/
```

---

## 🧱 Technologies Used

* Python (sklearn, pandas, cloudpickle, uvicorn)
* FastAPI / Flask (API)
* R Shiny (Web interface)
* Jupyter Notebook
* Git version control

---

## ✨ Author

**Tran Minh Tho**
Email: [tranminhtho100@gmail.com](mailto:tranminhtho100@gmail.com)
GitHub: [https://github.com/TranTho918](https://github.com/TranTho918)

```

