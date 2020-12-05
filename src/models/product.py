from sqlalchemy import Column, Integer, Numeric, String, Date, func, ForeignKey
from sqlalchemy.orm import relationship, backref
from db import Base
from models.links import links_products_categories

class Product(Base):
    __tablename__ = 'Product'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    brand = Column(String)
    manufacturer = Column(String)
    manufacture_date = Column(Date, default=func.now())
    cost = Column(Numeric)
    #order_id = Column(Integer, ForeignKey('Order.id'))
    #Order = relationship("Order", backref=backref("Product", uselist=False), cascade="all, delete")
    Categories = relationship("Category", secondary=links_products_categories, cascade="all, delete")
    def __repr__(self):
      return "<Product(name='%s'," \
             " brand='%s'," \
             " manufacturer='%s'," \
             " manufacture_date='%s'," \
             " cost='%i', " % \
             (self.name,
              self.brand,
              self.manufacturer,
              self.manufacture_date,
              self.cost)

    def __init__(self,
                 name: str,
                 brand: str,
                 manufacturer: str,
                 manufacture_date: str,
                 cost: int):
        self.name = name
        self.brand = brand
        self.manufacturer = manufacturer
        self.manufacture_date = manufacture_date
        self.cost = cost
