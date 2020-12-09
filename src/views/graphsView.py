from CUI.constructor import CUI
from visualzation.graphs import getTop15Categories


class GraphsView(object):
    def __init__(self):
        self.CUI = CUI('Graphs menu')
        self.CUI.addField('Top 15 categories', lambda: getTop15Categories())

    def run(self):
        self.CUI.run()

