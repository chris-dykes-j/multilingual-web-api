from flask import Flask, jsonify, request
import psycopg2, sys

# instance of flask
app = Flask(__name__)

# connection, very safe!
conn = psycopg2.connect(
    database='multilingual',
    user='guest',
    password='coolpasswordbro',
    host='192.46.222.118',
    port='5432'
)


@app.route('/')
def index():
    return 'Hi mom'


@app.route('/language')
def get_languages():
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM languages''')
    result = cursor.fetchall()
    return jsonify(result)


@app.route('/item')
def get_items():
    cursor = conn.cursor()
    language = request.args.get('language')
    if language is None:
        language = 'en'
    cursor.execute(f'''
        select * from items
        join description_translations as dt on items.id = dt.item_id
        where dt.language_code = \'{language}\'''')
    result = cursor.fetchall()
    return jsonify(result)


@app.route('/item-two')
def get_items_two():
    cursor = conn.cursor()
    language = request.args.get('language')
    print(language, file=sys.stdout)
    if language is None:
        language = 'en'
    print(language, file=sys.stdout)
    cursor.execute(f'''
        select items.*, nt.translation, dt.translation from items
        left join name_translations as nt on items.id = nt.item_id and nt.language_code = \'{language}\'
        left join description_translations as dt on items.id = dt.item_id and dt.language_code = \'{language}\'
        ''')

    result = cursor.fetchall()
    return jsonify(result)
