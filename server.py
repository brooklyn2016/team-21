from flask import Flask, request
import os
import json

app = Flask(__name__)

#I propose this terrible list
#it will be our "database"
theList = []

@app.route('/')
def hello_world():
    return ':p'

@app.route('/getRoster', methods=['GET'])
def getRoster():
    return json.dumps(theList)

@app.route('/meaning', methods=['GET', 'POST'])
def meaning():
    if request.method == 'POST':
        theList.append("banana fest")
        return "This means: Apple"
    else:
        return "Meaning uploaded!! :D"

if __name__ == "__main__":
    if os.environ.get('FORCE_B_W_U') == 'None':
        app.run(debug=True)
    else:
        app.run(host='0.0.0.0')
