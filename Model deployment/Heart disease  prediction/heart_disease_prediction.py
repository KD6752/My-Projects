import pandas as pd
from sklearn.ensemble import RandomForestClassifier
import streamlit as st

st.write("""
## This is simple Random forest model for Predicting Heart disease.
""")

st.sidebar.header("**Parameters**")


def input_parameters():
    age = st.sidebar.slider("Age", 20, 120, 45)
    sex = st.sidebar.selectbox("Sex", ["Male", "Female"])
    if sex == "Male":
        sex = 1
    else:
        sex = 0
    cp = st.sidebar.selectbox("Chest Pain", ["Typical Angina", "Atypical angina", "Non-angical pain", "Asymptomatic"])
    if cp == "Typical Angina":
        cp = 0
    elif cp == "Atypical angina":
        cp = 1
    elif cp == "Non-angical pain":
        cp = 2
    else:
        cp = 3
    trestbps = st.sidebar.slider("Resting Blood Pressure in mm Hg", 45, 250, 120)
    chol = st.sidebar.slider("Serum Cholesterol", 0, 600, 120)
    fbs = st.sidebar.selectbox("Fasting Blood Sugar level above 120 ?", ["Yes", "NO"])
    if fbs == "Yes":
        fbs = 1
    else:
        fbs = 0

    restecg = st.sidebar.slider('Rest ECG: 0->Normal, 1-> ST-T abnormal, 2-> ventricular hypertrophy', 0, 2, 1)
    thalach = st.sidebar.slider("Maximum heart rate during stress test", 45, 250, 100)
    exang = st.sidebar.slider("Exercise Induced angina 1->Yes, 0-> No", 0, 1)
    oldpeak = st.sidebar.number_input("ST depression induced by exercise")
    slope = st.sidebar.slider("ST segment 0-> upsloping, 1-> Flat, 2-> Downsloping", 0, 2, 1)
    ca = st.sidebar.slider("Number of major vessels colored by fluoroscopy (0-4)", 0, 4, 2)
    thal = st.sidebar.slider(
        "Thalium stress test 0->Normal, 1-> Fixed defect, 2-> Reversible defect, 3-> Not describe", 0, 3, 2)

    input_data = {
        "age": age,
        "sex": sex,
        "cp": cp,
        "trestbps": trestbps,
        "chol": chol,
        "fbs": fbs,
        "restecg": restecg,
        "thalach": thalach,
        "exang": exang,
        'oldpeak': oldpeak,
        "slope": slope,
        "ca": ca,
        "thal": thal
    }
    features = pd.DataFrame(input_data, index=[0])
    return features


input_df = input_parameters()

st.subheader("Patient's input parameters")
st.write(input_df)

df = pd.read_csv("heart.csv")
y = df["target"]
X = df.drop("target", axis=1)
clf = RandomForestClassifier()
clf.fit(X, y)

# df_r = pd.DataFrame([45, 1, 2, 125, 200, 1, 1, 120, 0, 2.8, 1, 2, 1])
# input_df = df_r.transpose()

prediction = clf.predict(input_df)
prediction_probablity = clf.predict_proba(input_df)
if prediction == 0:
    st.write("**No Heart Disease**")
    st.write("Prediction probablity:=", prediction_probablity[0][0])
else:
    st.write("**Presence of Heart Disease**")
    st.write("Prediction probablity:=", prediction_probablity[0][1])

# prediction_df=pd.DataFrame(prediction,index=[0])
