import requests
from bs4 import BeautifulSoup
import sys
import signal

URL = 'http://alldic.daum.net/search.do?q={}'


def interrupt_handler(sig, frame):
    error_exit('Interrupted')


def error_exit(reason):
    print(reason)
    sys.exit(1)


def print_usage():
    sys.exit(1)


if __name__ == '__main__':
    signal.signal(signal.SIGINT, interrupt_handler)

    if not sys.argv[1]:
        print_usage()

    try:
        r = requests.get(URL.format(sys.argv[1]))
        s = r.content
    except requests.exceptions.ConnectionError:
        error_exit('No network connection')

    soup = BeautifulSoup(s, 'html.parser')
    card_words = soup.find_all('div', class_='card_word')

    if len(card_words) == 0:
        error_exit('No result')

    # fetch first result card
    card_word = card_words[0]
    list_search = card_word.find('ul', class_='list_search')

    if not list_search:
        error_exit('No result')

    lis = list_search.find_all('li')
    txt_list = []
    for li in lis:
        txt = li.find('span', class_='txt_search').text
        txt_list.append(txt)

    print(' / '.join(txt_list))
