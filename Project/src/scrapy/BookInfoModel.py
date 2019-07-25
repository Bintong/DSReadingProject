import common
from bookstore.BookDBManager import BookDBManager

class BookInfoModel:

    book_name = ''
    book_author = ''
    book_id = ''
    book_type = ''
    book_img = ''
    book_to_url = ''
    book_abstract = ''
    book_year = ''
    book_classification = ''
    book_publisher = ''

    def __init__(self):
        pass

    @property
    def book_name(self):
        print 'reading book name'
        return self.book_name

    @book_name.setter
    def book_name(self, book_name):
        print('setting book name')
        self.book_name = book_name
        if self.book_name is not None:
            self.book_name = self.book_name.strip().replace("\n", "")
        else:
            self.book_name = ''

    @property
    def book_author(self):
        self.book_author

    @book_author.setter
    def book_author(self, book_author):
        self.book_author = book_author
        if self.book_author is not None:
            self.book_author = self.book_author.strip().replace("\n", "")
        else:
            self.book_author = ''

    @property
    def book_id(self):
        self.book_id

    @book_id.setter
    def book_id(self, book_id):
        self.book_id = book_id
        if self.book_id is not None:
            pass
        else:
            book_id = ''
    @property
    def book_type(self):
        self.book_type

    @book_type.setter
    def book_type(self, book_type):
        self.book_type = book_type
        if self.book_type is not None:
            self.book_type = self.book_type.strip().replace("\n", "")
        else:
            self.book_type = ''

    @property
    def book_img(self):
        self.book_img

    @book_img.setter
    def book_img(self, book_img):
        self.book_img = book_img
        if self.book_img is not None:
            self.book_img = self.book_img.strip().replace("\n", "")
        else:
            self.book_img = ''

    @property
    def book_to_url(self):
        self.book_to_url

    @book_to_url.setter
    def book_to_url(self, book_to_url):
        self.book_to_url = book_to_url
        if self.book_to_url is not None:
            self.book_to_url = self.book_to_url.strip().replace("\n", "")
        else:
            self.book_to_url = ''

    @property
    def book_abstract(self):
        self.book_abstract

    @book_abstract.setter
    def book_abstract(self, book_abstract):
        self.book_abstract = book_abstract
        if self.book_abstract is not None:
            self.book_abstract = self.book_abstract.strip().replace("\n", "")
        else:
            self.book_abstract = ''

    @property
    def book_year(self):
        self.book_year

    @book_year.setter
    def book_year(self, book_year):
        self.book_year = book_year
        if self.book_year is not None:
            self.book_year = self.book_year.strip().replace("\n", "")
        else:
            self.book_year = ''
    @property
    def book_classification(self):
        self.book_classification

    @book_classification.setter
    def book_publisher(self, book_classification):
        self.book_classification = book_classification
        if self.book_classification is not None:
            self.book_classification = self.book_classification.strip().replace("\n", "")
        else:
            self.book_classification = ''

    def display_detail(self, html_string):
        print html_string

    def save_db(self):
        db_table_name = 'xiaoxiong_newBook_tab'
        manager = BookDBManager()
        db = manager.connection_db()
        if(manager.has_data('title', self.book_name, db, db_table_name)):
            print 'db %s already have ' % self.book_name.encode("utf-8")
        else:
            info = {'title': self.book_name, 'img': self.book_img, 'author': self.book_author,
                    'publisher': self.book_author,
                    'time': self.book_year, 'href': self.book_to_url, 'index': self.book_id,
                    'abstract': self.book_abstract}

            manager.insert_data_json(db, db_table_name, info)
