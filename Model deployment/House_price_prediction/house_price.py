import streamlit as st
import joblib
import pandas as pd

loaded_model = joblib.load(open('house_price.pkl', "rb"))
st.sidebar.title("House Features")


def house_features():
    area = st.sidebar.number_input("Total Area Of Your House", 500, 10000, 3000)
    bedroom = st.sidebar.slider("Number of Bedroom", 1, 15, 4)
    bathroom = st.sidebar.slider("Number of Bathroom", 1, 8, 3)
    stories = st.sidebar.slider("Number of Stories", 1, 10, 2)
    mainroad = st.sidebar.selectbox("House on Main Road ?", ["Yes", "NO"])
    if mainroad == "Yes":
        mainroad = 1
    else:
        mainroad = 0

    guestroom = st.sidebar.selectbox("Has Guestroom ?", ["Yes", "NO"])
    if guestroom == "Yes":
        guestroom = 1
    else:
        guestroom = 0

    basement = st.sidebar.selectbox("Has Basement ?", ["Yes", "NO"])
    if basement == "Yes":
        basement = 1
    else:
        basement = 0

    hotwaterheating = st.sidebar.selectbox("Has Hot Water Heating ?", ["Yes", "No"])
    if hotwaterheating == "Yes":
        hotwaterheating = 1
    else:
        hotwaterheating = 0

    aircondition = st.sidebar.selectbox("Has Air Condition ?", ["Yes", "NO"])
    if aircondition == "Yes":
        aircondition = 1
    else:
        aircondition = 0

    prefarea = st.sidebar.selectbox("House on Prefer Area ?", ["Yes", "NO"])
    if prefarea == "Yes":
        prefarea = 1
    else:
        prefarea = 0
    parking = st.sidebar.slider("Number of Parking space?", 1, 10, 3)

    furnishingstatus = st.sidebar.selectbox("Furnished Hosue?", ["Furnished", "Unfurnished"])
    if furnishingstatus == "Furnished":
        furnishingstatus = 1
    else:
        furnishingstatus = 0

    features = {
        "area": area,
        "bedrooms": bedroom,
        "bathrooms": bathroom,
        "stories": stories,
        "mainroad": mainroad,
        "guestroom": guestroom,
        "basement": basement,
        "hotwaterheating": hotwaterheating,
        "airconditioning": aircondition,
        "parking": parking,
        "prefarea": prefarea,
        'furnishingstatus': furnishingstatus

    }

    df_features = pd.DataFrame(features, index=[0])
    return df_features


url = "https://www.kaggle.com/datasets/yasserh/housing-prices-dataset"
df_house_features = house_features()
# st.subheader("**Features Selected**")
# st.write(df_house_features)
st.subheader("Simple Linear Regression for House Price Prediction")
st.write("Dataset can be found [here](%s)" % url)
st.subheader("**House Price Prediction**")
prediction = round(loaded_model.predict(df_house_features)[0])
st.write("$", prediction)
