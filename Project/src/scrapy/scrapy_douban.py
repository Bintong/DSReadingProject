# coding=utf-8
from bs4 import BeautifulSoup, Comment
import urllib
import emoji
from BookInfoModel import BookInfoModel
from BookPopularModel import BookPopularModel
from bookstore.BookDBManager import BookDBManager

def test_beautiful():
    doc = ['<html><head><title>Page title</title></head>',
           '<body><p id="firstpara" align="center">This is paragraph <b>one</b>.',
           '<p id="secondpara" align="blah">This is paragraph <b>two</b>.',
           '</html>']
    soup = BeautifulSoup(''.join(doc))
    print soup.prettify()


def begin_scrapty_douban():
    manager = BookDBManager()
    url = 'https://book.douban.com'
    html = urllib.urlopen(url)
    soup = BeautifulSoup(html,"html.parser")
    list_books_item = soup.find('ul', class_="list-col list-col2 list-summary s")

    list_item = list_books_item.find_all('li')
    for subItem in list_item:
        book = BookInfoModel()
        book.book_name = subItem.find('div',class_ = 'info').a.string   #title
        book.book_img = subItem.a.img.get('src') #book img
        book.book_to_url = subItem.find('div',class_ = 'info').a.get('href') #to url
        book.book_author = subItem.find('p', class_='author').string #author
        book.book_abstract = subItem.find('p', class_='reviews').contents[0].strip().replace("\n", "")
        book.book_classification = subItem.find('p', class_='book-list-classification').string
        book.book_year = None
        book.book_type = None
        num = manager.get_db_itemsNum('xiaoxiong_newBook_tab')

        book.book_id = num
        book.display_detail(subItem)
        book.save_db()

def most_popular_book_review(page_begin_index):
    manager = BookDBManager()
    index = '%d' %(page_begin_index)
    url = 'https://book.douban.com/review/best/?start=' + index
    html = urllib.urlopen(url)
    soup = BeautifulSoup(html,"html.parser")
    list_popular_reviews = soup.find_all('div', class_ = 'main review-item')
    for subItem in list_popular_reviews:
        pop = BookPopularModel()
        pop.title = subItem.h2.a.string
        pop.book_name = subItem.find('img').get('title')   #title
        pop.user_name = subItem.find(class_ = 'name').string
        pop.time = subItem.find(class_ = 'main-meta').string
        pop.book_img = subItem.img.get('src')
        pop.book_id = subItem.get('id')
        pop.book_href = subItem.a.get('href')
        pop.sub_articl = subItem.find(class_ = 'short-content').text.strip().replace("\n", "")
        num = manager.get_popdb_items_num()
        pop.book_num = num
        pop.display_detail(subItem)
        pop.save_db()


if __name__ == '__main__':
    # begin_scrapty_douban()

    for num in range(0 , 10):
        most_popular_book_review(num * 20)