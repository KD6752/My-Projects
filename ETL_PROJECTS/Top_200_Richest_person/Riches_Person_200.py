# Importing the required libraries
from pprint import pprint

from bs4 import BeautifulSoup
import pandas as pd
from datetime import datetime
import sqlite3
from selenium import webdriver

url = "https://www.forbes.com/billionaires/"
table_attribs = ["Rank", "Name", "Net_Worth", "Age", "Company", "Type"]
db_name = 'Richest_person_200.db'
table_name = 'Richest_Person_200'
csv_path = "/Users/kokildhakal/PycharmProjects/ETL_PROJECTS/Highest_Mountains/billionaires.csv"


def extract(url, table_attribs):
    ''' This function extracts the required
    information from the website and saves it to a dataframe. The
    function returns the dataframe for further processing. '''
    driver = webdriver.Chrome()
    driver.get(url)
    html_content = driver.page_source
    driver.quit()
    soup = BeautifulSoup(html_content, 'html.parser')
    persons = soup.find_all('div', class_="Table_dataCell__2QCve")
    list_of_val = []

    for person in persons:
        person = person.text
        list_of_val.append(person)

    variables_per_row = 6
    rows = [list_of_val[i:i + variables_per_row] for i in range(0, len(list_of_val), variables_per_row)]
    df = pd.DataFrame(rows, columns=table_attribs)

    return df


def transform(df):
    ''' This function converts the GDP information from Currency
    format to float value, transforms the information of GDP from
    USD (Millions) to USD (Billions) rounding to 2 decimal places.
    The function returns the transformed dataframe.'''
    # removing $ and B symbol and converting to numerical values so that we could use it for calculations.
    worth_list = df["Net_Worth"].to_string(index=False)
    worth_list = worth_list.replace("B", "")
    worth_list = worth_list.replace("$", "")
    worth_list = worth_list.split("\n")
    df["Net_Worth"] = worth_list

    # df.rename(columns={"Net_Worth":"Worth_In_Billions"},inplace=True)
    df.rename(columns={"Net_Worth": "Worth_In_Billions"}, inplace=True)

    df["Worth_In_Billions"] = pd.to_numeric(df["Worth_In_Billions"], errors='coerce')
    return df


def load_to_csv(df, csv_path):
    ''' This function saves the final dataframe as a `CSV` file
    in the provided path. Function returns nothing.'''
    df.to_csv(csv_path)


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
    with open("./Richest_person_200.txt", "a") as f:
        f.write(timestamp + ' : ' + message + '\n')


''' Here, you define the required entities and call the relevant 
functions in the correct order to complete the project. Note that this
portion is not inside any function.'''

log_progress("Starting the ETL process")
df = extract(url, table_attribs)
log_progress("Data extraction complete,Starting The Transformation Process")
df = transform(df)
log_progress("Data Transformation Complete, loading to csv")
load_to_csv(df, csv_path)
log_progress("Data save as csv. data loading to db started")
sql_connection = sqlite3.connect('Richest_person_200.db')
load_to_db(df, sql_connection, table_name)
log_progress("data loaded to database,query process started")
query_statement = f"SELECT * FROM {table_name} WHERE Worth_In_Billions >=100"
run_query(query_statement, sql_connection)
log_progress("Process complete")
sql_connection.close()
