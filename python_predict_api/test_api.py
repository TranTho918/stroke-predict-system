import requests

# URL của API trên Render
API_URL = "https://python-predict-api.onrender.com/predict"

# Dữ liệu mẫu (giống input lúc train)
data = {
    "age": 67,
    "hypertension": 0,
    "heart_disease": 1,
    "ever_married": 1,
    "work_type": "Private",
    "avg_glucose_level": 228.69,
    "bmi": 36.6,
    "smoking_status": "formerly smoked"
}

# Gửi POST request
response = requests.post(API_URL, json=data)

# In kết quả trả về
print("Status code:", response.status_code)
print("Response JSON:", response.json())
