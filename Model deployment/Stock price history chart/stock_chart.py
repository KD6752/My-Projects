import streamlit as st
import pandas as pd
import yfinance as yf

st.write(
    """
    ## Simple Stock Price App
    Shown are the stock **Closing price** and **Volume** of Respective Company!
    """
)

tickerSymbol = st.sidebar.selectbox("Chose One", ["AAPL", "MSFT", "NVDA", "GOOG", "GOOGL", "AMZN", "META", "TSLA"])
# tickerSymbol = "AAPL"
tickerData = yf.Ticker(tickerSymbol)
print(tickerData)
tickerDf = tickerData.history(period="id", start="2000-01-01", end="2024-04-15")
st.write("This chart is for the Ticker:",tickerSymbol)

st.line_chart(tickerDf.Close)
st.line_chart(tickerDf.Volume)
