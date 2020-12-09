from CUI.constructor import CUI
from parsingData.parseCsv import parse1, parse2
from scrapping.amazon import getProductsByCategory


class DataView(object):
    def __init__(self):
        self.CUI = CUI('New data menu')
        self.CUI.addField('Scrapping', lambda: self.__scrapping())
        self.CUI.addField('Parsing', lambda: self.__parsingDataSets())

    def run(self):
        self.CUI.run()

    def __scrapping(self):
        localMenu = CUI('Scrapping data')
        localMenu.addField('Get data from Amazon', lambda: getProductsByCategory())
        localMenu.run()

    def __parsingDataSets(self):
        localmenu = CUI('Parsing CSV datasets')
        localmenu.addField('Parse set 1', lambda: parse1())
        localmenu.addField('Parse set 2', lambda: parse2())
        localmenu.run()
