from CUI.constructor import CUI
from visualzation.graphs import getTop15Categories, getManufactureDateStat


class GraphsView(object):
    def __init__(self):
        self.CUI = CUI('Graphs menu')
        self.CUI.addField('Top 15 categories', lambda: getTop15Categories())
        self.CUI.addField('Products per year statistic', lambda: getManufactureDateStat())

    def run(self):
        self.CUI.run()

