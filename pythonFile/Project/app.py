from flask import Flask
from bson.json_util import dumps
from flask import request

from src.bookstore.BookDBManager import BookDBManager

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route('/api/v1/main_info', methods=['GET', 'POST'])
def main():
    dbmanager = BookDBManager()
    db = dbmanager.connection_db()
    con = db['xiaoxiong_newBook_tab']
    con_ban = db['banners']
    page_num = int(request.form['pageNum'])
    items = con.find().skip(page_num * 10).limit(10).sort([("index",-1)])
    banners = con_ban.find().skip(0).limit(5)
    data = {'data': {'items': items}}
    return dumps(data)

# @app.route('/api/v1/main_list', methods = ['GET', 'POST'])
# def world_info():
#     dbmanager = BookDBManager()
#     db = dbmanager.get_db()
#     table = db['xiaoxiong_word_info_tab']
#     page_num = int(request.form['pageNum'])
#     items = table.find().skip(page_num * 10).limit(10).sort([("index",-1)])
#     data = {'data': items}
#     return dumps(data)

if __name__ == '__main__':
    app.run()
