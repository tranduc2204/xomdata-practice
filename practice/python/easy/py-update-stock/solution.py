# Xom Data · Add goods into the stock table
# Problem: https://xomdata.com/practice/py-update-stock
# Solved: 2026-08-21

from collections import Counter
def add_stock(stock, code, qty):
    c = Counter(stock)
    c.update({code: qty})
    return dict(c)
