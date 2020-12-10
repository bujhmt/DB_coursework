from CUI.constructor import CUI
from visualzation.graphs import getTop15Categories, getManufactureDateStat, getTransactionDateStat


class GraphsView(object):
    def __init__(self):
        self.CUI = CUI('Graphs menu')
        self.CUI.addField('Top 15 categories', lambda: getTop15Categories())
        self.CUI.addField('Products per year statistic', lambda: getManufactureDateStat())
        self.CUI.addField('Sale statistics', lambda :getTransactionDateStat())

    def run(self):
        self.CUI.run()

