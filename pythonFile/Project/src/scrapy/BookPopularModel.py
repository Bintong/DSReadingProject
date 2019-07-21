import common
from bookstore.BookDBManager import BookDBManager

class BookPopularModel:

    title = ''
    user_name = ''
    book_name = ''
    time = ''
    sub_articl = ''
    book_href = ''
    book_img = ''
    book_id = ''


    def __init__(self):
        pass

    @property
    def title(self):
        print 'reading book name'
        return self.title

    @title.setter
    def title(self, title):
        self.title = title
        if self.title is not None:
            self.title = self.title.strip().replace("\n", "")
        else:
            self.title = ''

    @property
    def user_name(self):
        return self.user_name

    @user_name.setter
    def user_name(self, user_name):
        self.user_name = user_name
        if self.user_name is not None:
            self.user_name = self.user_name.strip().replace("\n", "")
        else:
            self.title = ''

    @property
    def book_name(self):
        return self.book_name

    @book_name.setter
    def book_name(self, book_name):
        self.book_name = book_name
        if self.book_name is not None:
            self.book_name = self.book_name.strip().replace("\n", "")
        else:
            self.book_name = ''

    @property
    def time(self):
        return self.time

    @time.setter
    def time(self, time):
        self.time = time
        if self.time is not None:
            self.time = self.time.strip().replace("\n", "")
        else:
            self.time = ''

    @property
    def sub_articl(self):
        return self.sub_articl

    @sub_articl.setter
    def sub_articl(self, sub_articl):
        self.sub_articl = sub_articl
        if self.sub_articl is not None:
            self.sub_articl = self.sub_articl.strip().replace("\n", "")
        else:
            self.sub_articl = ''

    @property
    def book_href(self):
        return self.book_href

    @book_href.setter
    def book_href(self, book_href):
        self.book_href = book_href
        if self.book_href is not None:
            self.book_href = self.book_href.strip().replace("\n", "")
        else:
            self.book_href = ''

    @property
    def book_img(self):
        return self.book_img

    @book_img.setter
    def book_img(self, book_img):
        self.book_img = book_img
        if self.book_img is not None:
            self.book_img = self.book_img.strip().replace("\n", "")
        else:
            self.book_img = ''

    @property
    def book_id(self):
        return self.book_id

    @book_id.setter
    def user_name(self, book_id):
        self.book_id = book_id
        if self.book_id is not None:
            self.book_id = self.book_id.strip().replace("\n", "")
        else:
            self.book_id = ''


    def display_detail(self, html_string):
        print html_string

    def save_db(self):
        db_table_name = 'xiaoxiong_pop_book_tab'
        manager = BookDBManager()
        db = manager.connection_db()
        if(manager.has_data('title', self.book_name, db, db_table_name)):
            print 'db %s already have ' % self.book_name.encode("utf-8")
        else:
            info = {'title': self.title,
                    'user_name': self.user_name,
                    'book_name': self.book_name,
                    'time': self.time,
                    'book_id': self.book_id,
                    'sub_articl': self.sub_articl,
                    'book_href': self.book_href,
                    'book_img': self.book_img}

            manager.insert_data_json(db, db_table_name, info)
