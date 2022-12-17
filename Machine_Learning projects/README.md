<h1 align="center">Final Project: Data Analysis with Python</h1>

## Instructions

[instructions.pdf](instructions.pdf)

## Topic

Predicting Housing Prices (Linear Regression)
comparing with random forest and gradient boosting models

## Description
We used three models (linear regression, random forest regression and gradient boosting) to predict house prices.
The data we used is in raw format. We had to do pre-processing before analyzing the data. We dropped a 
few columns that has high number of NaN values that has no effect on determining sale price. We 
also used the dropna method to drop NaN values. To deal with outliers, we used a three standard deviation threshold value.

## Project Requirements/technology used

There are several technologies/applications we used to complete this project.
We use Python, Jupyter Notebook, Git/GitHub, along with various modules like sklearn (for the linear regressor, random forest regressor, and gradient boosting ML algorithms), numpy, scipy, pandas, and matplotlib.

## Steps used to get results:

### Getting data sets
We got our data from GitHub URL:
[House Prediction Data.csv](https://github.com/bursteinalan/Data-Sets/tree/master/Housing)

### Finding highly correlated attributes(columns):
We used the following script to find the highly correlated columns with 'SalePrice', where df_filtered is cleaned data frame.

correl_dict = dict()
for column in df_filtered.columns[:-1]:
    correl_dict[column] = sp.linregress(df_filtered[column], df_filtered['SalePrice']).rvalue
correl_df = pd.DataFrame.from_dict(correl_dict, orient='index', columns=['Correl coef'])

There were six columns that were highly correlated with 'SalePrice'. We used those columns as our
selected attributes. These columns were: 'OverallQual', 'ExterQual', 'GrLivArea', ’KitchenQual', 'GarageCars', and
'GarageArea'.

### Dividing data into train and test set:
We use following SKlearn sript to split our data set
X=df_filtered.drop(['SalePrice'],axis=1)
y=df_filtered['SalePrice']

X_train,X_test,y_train,y_test,=train_test_split(X,y,test_size=0.30,random_state=10)
X_train.shape,X_test.shape

We chose 30% of our total data for testing and 70% for training the models, we also give some flexibility with randomness (random_state=10) of choosing data for test and train from original 
data set.

### Fitting different models and finding errors and accuracy:
We use three different regressor models namely 'Linear Regression', 'Random Forest' and
'Gradient Boosting' using SKLearn, which is basically to import the model and fit in our data
set.

## Use of project:
For predicting price of house, we need to have attributes available, for example
we need to have value of overall quality of house, gross living area, garage size
external quality of house and kitchen quality and we can put this value to as a
X_test in following equations
predictions = model.predict(X_test)
where model can be linear, random forest or gradient boosting.

## Credits/Appreciation:

Two people were involved in this project those are the authors listed at bottom of
this file. We are also like to appreciate guidance from our professor Alan Burstein and
TA Yingshi Huang.


## Tech Stack

- Python
- Jupyter
- Git/GitHub

## Authors

[Kokil Dhakal](https://github.com/KD6752)

[Dan Hoogasian](https://github.com/DHoog4)  
