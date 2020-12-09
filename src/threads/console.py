# from tkinter import *
from db import session
from models.product import Product
from CUI.constructor import CUI
import math

class test(object):

    def __init__(self):
        self.tags_page = 1
        self.per_page = 10


    def updateTags(self, newPage: int, menu):
        self.tags_page = newPage
        menu.stop()
        self.getTags()

    def getTags(self):
        menu = CUI('Tags menu')
        tags = session.query(Product).filter(Product.cost > 2000)\
            .offset(self.tags_page * self.per_page).limit(self.per_page) \
            .all()
        count = session.query(Product).filter(Product.cost > 2000).count()
        menu.setMsg(f'Page: {self.tags_page}/{math.floor(count / self.per_page)}')

        if self.tags_page < math.floor(count / self.per_page):
            menu.addField('NEXT', lambda: self.updateTags(self.tags_page + 1, menu))
        if self.tags_page > 1:
            menu.addField('PREV', lambda: self.updateTags(self.tags_page - 1, menu))

        for tag in tags:
            menu.addField(f"{tag.name}")
        menu.run('Back to prev menu')