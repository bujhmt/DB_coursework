import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from db import session
from models.category import Category
from models.product import Product
from sqlalchemy import func


def getTop15Categories():
    results = session.query(Category.name, func.count(Category.name).label('count')) \
        .join(Product, Category.Products) \
        .group_by(Category.name) \
        .order_by(func.count('count').desc()) \
        .limit(15).all()

    listed = list(zip(*results))
    series = pd.Series(np.array(listed[1]), index=listed[0], name='')

    series.plot.pie(figsize=(9, 7), title="Top 15 categories:")

    plt.plot(series)
    plt.show()

