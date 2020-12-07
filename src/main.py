from db import session, recreate_database
from views.modelView import EntityView
from CUI.constructor import CUI
from models.client import Client
from models.order import Order
from models.category import Category
from models.product import Product

#dev:
from parsingData.parseCsv import parse1, parse2
from parsingData.parseJSON import parse3
from visual.testPandas import run

#recreate_database()
if __name__ == '__main__':
    #recreate_database()
    run()
    # parse1()
    # parse2()
    # cui = CUI('CUI')
    # cui.addField('Clients', lambda: EntityView(Client).run())
    # cui.addField('Orders', lambda: EntityView(Order).run())
    # cui.addField('Categories', lambda: EntityView(Category).run())
    # cui.addField('Product', lambda: EntityView(Product).run())
    # cui.run()
    session.close()


