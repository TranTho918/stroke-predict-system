import warnings
warnings.filterwarnings("ignore", category=UserWarning)
warnings.filterwarnings("ignore", category=FutureWarning)

import cloudpickle
import pandas as pd
from pathlib import Path

model_dir = Path("models")
logreg_model = cloudpickle.load(open(model_dir / "stroke_rate_logistic.pkl", "rb"))
svm_model = cloudpickle.load(open(model_dir / "stroke_rate_svm.pkl", "rb"))
xgb_model = cloudpickle.load(open(model_dir / "stroke_rate_xgboost.pkl", "rb"))

# ============================================================
# Define columns
# ============================================================
base_features = [
    "age", "hypertension", "heart_disease", "ever_married",
    "work_type", "avg_glucose_level", "bmi", "smoking_status"
]

interaction_features = [
    "age_glucose_interaction", "age_bmi_interaction", "high_risk"
]

# ============================================================
# Logistic + SVM (with feature interaction)
# ============================================================
def preprocess_logis_svm(user_input: dict) -> pd.DataFrame:
    df = pd.DataFrame([user_input])
    df["age"] = df["age"].astype(float)
    df["hypertension"] = df["hypertension"].astype(int)
    df["heart_disease"] = df["heart_disease"].astype(int)
    df["ever_married"] = df["ever_married"].astype(int)
    df["work_type"] = df["work_type"].astype(str)
    df["avg_glucose_level"] = df["avg_glucose_level"].astype(float)
    df["bmi"] = df["bmi"].astype(float)
    df["smoking_status"] = df["smoking_status"].astype(str)

    # ✅ Feature interaction
    df["age_glucose_interaction"] = df["age"] * df["avg_glucose_level"]
    df["age_bmi_interaction"] = df["age"] * df["bmi"]
    df["high_risk"] = ((df["hypertension"] == 1) | (df["heart_disease"] == 1)).astype(int)

    ordered_cols = base_features + interaction_features
    return df[ordered_cols]

# ============================================================
# XGBoost (no interaction)
# ============================================================
def preprocess_xgb(user_input: dict) -> pd.DataFrame:
    df = pd.DataFrame([user_input])

    # 🔹 Chuyển numeric 0/1 sang "No"/"Yes" cho đúng dạng train
    if df["ever_married"].iloc[0] in [0, 1]:
        df["ever_married"] = df["ever_married"].map({0: "No", 1: "Yes"})
    else:
        df["ever_married"] = df["ever_married"].astype(str)

    # 🔹 Ép category cho các cột phân loại
    df["work_type"] = pd.Categorical(df["work_type"])
    df["smoking_status"] = pd.Categorical(df["smoking_status"])
    df["ever_married"] = pd.Categorical(df["ever_married"])

    # 🔹 Các cột numeric
    df["age"] = df["age"].astype(float)
    df["hypertension"] = df["hypertension"].astype(int)
    df["heart_disease"] = df["heart_disease"].astype(int)
    df["avg_glucose_level"] = df["avg_glucose_level"].astype(float)
    df["bmi"] = df["bmi"].astype(float)

    return df[[
        "age", "hypertension", "heart_disease", "ever_married",
        "work_type", "avg_glucose_level", "bmi", "smoking_status"
    ]]


# ============================================================
# Predict wrapper
# ============================================================
def predict_stroke(user_input: dict) -> dict:
    df_logis = preprocess_logis_svm(user_input)
    df_svm = preprocess_logis_svm(user_input)
    df_xgb = preprocess_xgb(user_input)

    def safe_predict(model, X):
        if hasattr(model, "predict_proba"):
            return float(model.predict_proba(X)[:, 1][0])
        else:
            return float(model.predict(X)[0])

    pred_logis = safe_predict(logreg_model, df_logis)
    pred_svm = safe_predict(svm_model, df_svm)
    pred_xgb = safe_predict(xgb_model, df_xgb)

    return {
        "logistic": round(pred_logis, 4),
        "svm": round(pred_svm, 4),
        "xgboost": round(pred_xgb, 4)
    }
