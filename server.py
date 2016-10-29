from flask import Flask, request
import os
import json

app = Flask(__name__)

@app.route('/')
def hello_world():
    return ':p'

@app.route('/getRoster', methods=['GET'])
def getRoster():
    return json.dumps(["John", "Joe", "Jill", "Jane"])

@app.route('/meaning', methods=['GET', 'POST'])
def meaning():
    if request.method == 'POST':
        return "This means: Apple"
    else:
        return "Meaning uploaded!! :D"

if __name__ == "__main__":
    if os.environ.get('FORCE_B_W_U') == 'None':
        app.run(debug=True)
    else:
        app.run(host='0.0.0.0')
