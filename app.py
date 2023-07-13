from flask import Flask, jsonify
import psycopg2

# instance of flask
app = Flask(__name__)


@app.route('/')
def index():
    return 'Hi mom'


@app.route('/language')
def get_languages():
    conn = psycopg2.connect(
        database="multilingual",
        user='guest',
        password='coolpasswordbro',
        host='192.46.222.118',
        port='5432'
    )
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM languages''')
    result = cursor.fetchall()
    return jsonify(result)

