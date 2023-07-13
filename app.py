from flask import Flask

# instance of flask
app = Flask(__name__)

@app.route('/')
def index():
    return 'Hi mom'