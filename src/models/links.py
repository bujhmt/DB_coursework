from sqlalchemy import Column, Integer, Table, ForeignKey
from  db import Base

links_orders_association = Table(
    'Link_Client-Order', Base.metadata,
    Column('client_id', Integer, ForeignKey('Client.id')),
    Column('order_id', Integer, ForeignKey('Order.id'))
)

links_products_categories = Table(
    'Link_Product-Category', Base.metadata,
    Column('product_id', Integer, ForeignKey('Product.id')),
    Column('category_id', Integer, ForeignKey('Category.id'))
)

