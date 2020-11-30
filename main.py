from db import session
from views.modelView import EntityView
from CUI.cui import CUI
from models.client import Client
from models.order import Order
from models.category import Category
from models.product import Product

if __name__ == '__main__':
    cui = CUI('CUI')
    cui.addField('Clients', lambda: EntityView(Client).run())
    cui.addField('Orders', lambda: EntityView(Order).run())
    cui.addField('Categories', lambda: EntityView(Category).run())
    cui.addField('Product', lambda: EntityView(Product).run())
    cui.run()
    session.close()


