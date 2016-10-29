from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello_world():
    return ':p'

if __name__ == "__main__":
    if os.environ.get('FORCE_B_W_U') == 'None':
        app.run(debug=True)
    else
        app.run(host='0.0.0.0')
