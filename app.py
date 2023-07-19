from flask import Flask, jsonify, request
import psycopg2

# instance of flask
app = Flask(__name__)

@app.route('/')
def index():
    return 'Hi mom'

@app.route('/language')
def get_languages():
    conn = psycopg2.connect(
        database='multilingual',
        user='guest',
        password='coolpasswordbro',
        host='192.46.222.118',
        port='5432'
    )
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM languages''')
    result = cursor.fetchall()
    return jsonify(result)

@app.route('/item')
def get_items():
    conn = psycopg2.connect(
        database='multilingual',
        user='guest',
        password='coolpasswordbro',
        host='192.46.222.118',
        port='5432'
    )
    cursor = conn.cursor()
    language = request.args.get('language')
    if language is None:
        language = 'en'
    cursor.execute(f'''select * from items
        join description_translations dt on items.id = dt.item_id
        where dt.language_code = \'{language}\'''')
    result = cursor.fetchall()
    return jsonify(result)