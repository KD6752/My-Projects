# Code for ETL operations on Banks with high Market_Cap

# Importing the required libraries
from bs4 import BeautifulSoup
import requests
import pandas as pd
import numpy as np
import sqlite3
from datetime import datetime

url = 'https://web.archive.org/web/20230908091635/https://en.wikipedia.org/wiki/List_of_largest_banks'
table_attribs = ["Banks_name", "Market_Cap"]
db_name = 'World_Largest_Banks.db'
table_name = 'Largest_Bank'
csv_path = '/Users/kokildhakal/PycharmProjects/ETL_PROJECTS/exchange_rate.csv'
output_path = "/Users/kokildhakal/PycharmProjects/ETL_PROJECTS/bank_project.csv"


def log_progress(message):
    ''' This function logs the mentioned message of a given stage of the
    code execution to a log file. Function returns nothing'''
    timestamp_format = '%Y-%h-%d-%H:%M:%S'  # Year-Monthname-Day-Hour-Minute-Second
    now = datetime.now()  # get current timestamp
    timestamp = now.strftime(timestamp_format)
    with open("./world_banks_etl_log.txt", "a") as f:
        f.write(timestamp + ' : ' + message + '\n')


def extract(url, table_attribs):
    ''' This function aims to extract the required
    information from the website and save it to a data frame. The
    function returns the data frame for further processing. '''
    df = pd.DataFrame(columns=table_attribs)
    page = requests.get(url).text
    data = BeautifulSoup(page, "html.parser")

    tables = data.find_all("tbody")
    rows = tables[0].find_all('tr')
    cols = tables[0].find_all('td')
    data_frame = pd.DataFrame(columns=["Bank_Name", "Market_Cap"])
    data_list = []
    for row in rows[1:]:
        col = [td.text.strip() for td in row.find_all('td')]
        data_list.append(col)

    df = pd.DataFrame(data_list, columns=["rank", "Name", "Market_Cap"], )
    return df


def get_exchange_rate(currency):
    exchange_df = pd.read_csv(csv_path)
    exchange_df["Rate"] = pd.to_numeric(exchange_df["Rate"], errors="coerce")
    return exchange_df.loc[exchange_df['Currency'] == currency, "Rate"].values[0]




def transform(df):
    ''' This function accesses the CSV file for exchange rate
    information, and adds three columns to the data frame, each
    containing the transformed version of Market Cap column to
    respective currencies'''

    df["Market_Cap"] = pd.to_numeric(df["Market_Cap"], errors="coerce")

    df["EUR"] = df["Market_Cap"].apply(lambda x: round(x * get_exchange_rate("EUR"), 2))
    df["GBP"] = df["Market_Cap"].apply(lambda x: round(x * get_exchange_rate('GBP'), 2))
    df["INR"] = df["Market_Cap"].apply(lambda x: round(x * get_exchange_rate('INR'), 2))

    return df


def load_to_csv(df, output_path):
    ''' This function saves the final data frame as a CSV file in
    the provided path. Function returns nothing.'''
    df.to_csv(output_path, index=False)


def load_to_db(df, sql_connection, table_name):
    ''' This function saves the final data frame to a database
    table with the provided name. Function returns nothing.'''
    df.to_sql(table_name, sql_connection, if_exists= 'replace', index=False)


def run_query(query_statement, sql_connection):
    ''' This function runs the query on the database table and
    prints the output on the terminal. Function returns nothing. '''

    print(query_statement)
    query_out = pd.read_sql(query_statement, sql_connection)
    print(query_out)


''' Here, you define the required entities and call the relevant
functions in the correct order to complete the project. Note that this
portion is not inside any function.'''

log_progress("Preliminaries complete.Initiating ETL process")
df = extract(url, table_attribs)
log_progress("Data extraction complete.Initiating Transformation process")
df = transform(df)
load_to_csv(df,output_path)
log_progress("Data saved to CSV file")
sql_connection = sqlite3.connect("World_largest_Bank.db")
log_progress("SQL Connection initiated.")
load_to_db(df, sql_connection, table_name)
log_progress("Data loaded to Database as table.Running The Query")
query_statement = f"SELECT * FROM {table_name}"
run_query(query_statement, sql_connection)
log_progress("Process Complete.")
sql_connection.close()
