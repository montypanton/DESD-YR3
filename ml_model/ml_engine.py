import joblib
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score


# Data preprocessing class for loading dataset, handles missing values, sorts categortical data,
# splits data into sets, and scales numerical features. 
class DataPreprocessor:
    def __init__(self, file_path):
        self.file_path = file_path
        self.data = None
        self.X_train, self.X_test, self.y_train, self.y_test = None, None, None, None
        self.scaler = StandardScaler()
        self.label_encoders = {}
    
    def load_data(self):
        """Loads the dataset from CSV."""
        self.data = pd.read_csv(self.file_path)
        print("Data loaded successfully.")
    
    def handle_missing_values(self):
        """Fills missing values with column mean for numerical and mode for categorical."""
        for column in self.data.columns:
            if self.data[column].dtype == 'object':
                self.data[column].fillna(self.data[column].mode()[0], inplace=True)
            else:
                self.data[column].fillna(self.data[column].mean(), inplace=True)
        print("Missing values handled.")
    
    def encode_categorical_data(self):
        """Encodes categorical features using Label Encoding."""
        for column in self.data.select_dtypes(include=['object']).columns:
            le = LabelEncoder()
            self.data[column] = le.fit_transform(self.data[column])
            self.label_encoders[column] = le
        print("Categorical data encoded.")
    
    def split_data(self, target_column, test_size=0.2):
        """Splits data into training and testing sets."""
        X = self.data.drop(columns=[target_column])
        y = self.data[target_column]
        self.X_train, self.X_test, self.y_train, self.y_test = train_test_split(X, y, test_size=test_size, random_state=42)
        print("Data split into training and testing sets.")
    
    def scale_features(self):
        """Scales numerical features using StandardScaler."""
        self.X_train = self.scaler.fit_transform(self.X_train)
        self.X_test = self.scaler.transform(self.X_test)
        print("Features scaled.")
    
    def preprocess(self, target_column):
        """Runs all preprocessing steps in sequence."""
        self.load_data()
        self.handle_missing_values()
        self.encode_categorical_data()
        self.split_data(target_column)
        self.scale_features()
        print("Preprocessing complete.")


# aaaaaaaaaaaaaaaaaaaaaaaaaaaaa
# aaaaaaaaaaaaaaaaaaaaaaaaaaaaa
class MLEngine:
    def __init__(self, n_estimators=100, max_depth=None, random_state=42):
    # start random forest with set / random parameters
        self.model = RandomForestClassifier(
            n_estimators=n_estimators,
            max_depth=max_depth,
            random_state=random_state
        )
        self.label_encoders = {}  

    def train(self, file_path):
        df = pd.read_csv(file_path)

        X = df.iloc[:, :-1]  
        y = df.iloc[:, -1]   

        for column in X.columns:
            if X[column].dtype == 'object':  
                X[column].fillna(X[column].mode()[0], inplace=True)
                self.label_encoders[column] = LabelEncoder()
                X[column] = self.label_encoders[column].fit_transform(X[column])
            else:
                X[column].fillna(X[column].mean(), inplace=True)

        if y.dtype == 'object':
            target_encoder = LabelEncoder()
            y = target_encoder.fit_transform(y)

        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        self.model.fit(X_train, y_train)
        print("Model training complete.")

    def predict(self, X_test):
        return self.model.predict(X_test)

    def evaluate(self, y_true, y_pred):
    # still needs doing 
        pass