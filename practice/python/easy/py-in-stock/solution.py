# Xom Data · Count in-stock products
# Problem: https://xomdata.com/practice/py-in-stock
# Solved: 2026-08-21

def count_in_stock(quantities):
    quant = 0
    for i in quantities:
        if i > 0:
            quant+=1
    return quant
