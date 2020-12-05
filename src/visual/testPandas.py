import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


def test():
    ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000', periods=1000))
    ts = ts.cumsum()
    #ts.plot()
    plt.plot(ts)
    plt.show()
    # file = ts.get_figure()
    # file.savefig('../data/figure.pdf')


