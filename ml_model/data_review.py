import pandas as pd

file_path = "ml_model/Synthetic_Data_For_Students.csv"
df = pd.read_csv(file_path)

print("Dataset Overview:\n")
print(df.info()) 

print("\nFirst 5 Rows of the Dataset:\n")
print(df.head())

print("\nMissing Values in Each Column:\n")
print(df.isnull().sum())

print("\nSummary Statistics:\n")
print(df.describe())

print("\nColumn Names in Dataset:\n")
print(df.columns)
