# --------------------------------------------------------------------------------------------

# This file contains the code for the model server. The model server is a simple
# Flask server that listens for requests on a specified port and responds with

# --------------------------------------------------------------------------------------------


from ml_engine import MLEngine
from flask import Flask, request, jsonify

app = Flask(__name__)
model = MLEngine()

@app.route('/train', methods=['POST'])
def train_model():
    data = request.json  
    file_path = data.get('file_path', 'Synthetic_Data_For_Students.csv')
    
    model.train(file_path)  
    return jsonify({"message": "Model training complete!"})

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json  
    features = data.get('features', [])
    
    prediction = model.predict([features]) 
    return jsonify({"prediction": prediction.tolist()})

if __name__ == '__main__':
    app.run(port=5000)

    