import random
import json
from db import session

from models.category import Category
from models.product import Product
from models.links import links_products_categories

def parse3():
    with open('../data/json/amazon_one_plus_reviews.json') as file:
        data = json.load(file)

        # Adding Products to database:
        products_count = 0
        categories_count = 0
        links_count = 0
        for row in data:
            new_product = Product(row['product'],
                                  row['product_company'],
                                  row['product_company'],
                                  row['dateAdded'],
                                  random.randint(200, 5000))
            session.add(new_product)
            session.commit()
            products_count += 1
            session.refresh(new_product)

            # Adding categories to database:
            category_names = row['category'].split(',')

            for category_name in category_names:
                checked_categories = session.query(Category).filter(Category.name == category_name).all()
                if len(checked_categories) == 0:
                    new_category = Category(category_name, row['sub_category'])
                    session.add(new_category)
                    session.commit()
                    categories_count += 1
                    session.refresh(new_category)

                    # Adding link:
                    ins = links_products_categories.insert().values(product_id=new_product.id,
                                                                    category_id=new_category.id)
                    session.execute(ins)
                else:
                    ins = links_products_categories.insert().values(product_id=new_product.id,
                                                                    category_id=checked_categories[0].id)
                    session.execute(ins)
                links_count += 1
            session.commit()

        print(
            f'Added {products_count} products, {categories_count} categories and {links_count} links.\nPlease, press any key to continue')
        input()