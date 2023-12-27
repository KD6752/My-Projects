# Code for ETL operations on Richest People
import requests
from bs4 import BeautifulSoup
import requests
import pandas as pd
import numpy as np
import sqlite3
from datetime import datetime

url = "https://ceoworld.biz/2023/03/04/the-worlds-richest-people-top-billionaires-2023/"
table_attribs = ["rank", "Name", "Worth_in_Billion", "Country"]
db_name = 'Top_Riches_People.db'
table_name = 'Top_Richest_Person'
csv_path = '/Users/kokildhakal/PycharmProjects/ETL_PROJECTS/World_Richest_Person/richest_person.csv'


# output_path = "/Users/kokildhakal/PycharmProjects/ETL_PROJECTS/bank_project.csv"


# Importing the required libraries

def extract(url, table_attribs):
    ''' This function extracts the required
    information from the website and saves it to a dataframe. The
    function returns the dataframe for further processing. '''
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "html.parser")
    tables = soup.find_all("tbody")
    rows = tables[0].find_all("tr")
    cells = tables[0].find_all("td")
    data_list = []
    for row in rows:
        col = [td.text.strip() for td in row.find_all('td')]
        data_list.append(col)

    df = pd.DataFrame(data_list, columns=table_attribs)
    return df


def transform(df):
    ''' This function converts the GDP information from Currency
    format to float value, transforms the information of GDP from
    USD (Millions) to USD (Billions) rounding to 2 decimal places.
    The function returns the transformed dataframe.'''
    worth_list = df["Worth_in_Billion"].to_string(index=False)
    worth_list = worth_list.replace("billion", "")
    worth_list=worth_list.replace("$", "")
    worth_list = worth_list.split("\n")
    df["Worth_in_Billion"] = worth_list
    df["Worth_in_Billion"]= pd.to_numeric(df["Worth_in_Billion"],errors="coerce")

    return df


def load_to_csv(df, csv_path):
    ''' This function saves the final dataframe as a `CSV` file
    in the provided path. Function returns nothing.'''
    df.to_csv(csv_path, index=False)


# df = transform(df)
# load_to_csv(df, csv_path)


def load_to_db(df, sql_connection, table_name):
    ''' This function saves the final dataframe as a database table
    with the provided name. Function returns nothing.'''
    df.to_sql(table_name, sql_connection, if_exists='replace', index=False)


def run_query(query_statement, sql_connection):
    ''' This function runs the stated query on the database table and
    prints the output on the terminal. Function returns nothing. '''
    print(query_statement)
    query_out = pd.read_sql(query_statement, sql_connection)
    print(query_out)


def log_progress(message):
    ''' This function logs the mentioned message at a given stage of the code execution to a log file. Function
    returns nothing '''
    timestamp_format = '%Y-%h-%d-%H:%M:%S'  # Year-Monthname-Day-Hour-Minute-Second
    now = datetime.now()  # get current timestamp
    timestamp = now.strftime(timestamp_format)
    with open("./rich_person_log.txt", "a") as f:
        f.write(timestamp + ' : ' + message + '\n')


''' Here, you define the required entities and call the relevant 
functions in the correct order to complete the project. Note that this
portion is not inside any function.'''

log_progress("Starting the ETL process")
df = extract(url, table_attribs)
log_progress("Data extraction complete,Starting The Tranformation Process")
df = transform(df)
log_progress("Data Transformation Compolete, loading to csv")
load_to_csv(df, csv_path)
log_progress("Data save as csv. data loading to db started")
sql_connection = sqlite3.connect("Top_Richest_People.db")
load_to_db(df, sql_connection, table_name)
log_progress("data loaded to database,query process started")
query_statement = f"SELECT * FROM {table_name} WHERE Worth_in_Billion >=120"
run_query(query_statement, sql_connection)
log_progress("Process complete")
sql_connection.close()
