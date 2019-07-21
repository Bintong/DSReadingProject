
import pymongo
import common
class BookDBManager:
    host = ''
    port = 0

    def __init__(self):
        self.host = 'localhost'
        self.port = 27017




    def insert_data_json(self, db, dbname, json):
        collection = db[dbname]
        if collection.find().count() > 1000:
            collection.removeall
            collection.save(json)
        else:
            collection.save(json)



    def read_db(self):
        pass

    def connection_db(self):
        client = pymongo.MongoClient(host=self.host, port=self.port)
        db = client['book_db']
        return db

    def get_db_itemsNum(self, dbname):
        db = self.connection_db()
        collection = db[dbname]
        num = collection.find().count()
        return num


    def has_data(self, key, name, db, dbname):
        collection = db.get_collection(dbname)
        if collection:
            has = collection.find({key: name}).count() > 0
            return has
        else:
            return False
