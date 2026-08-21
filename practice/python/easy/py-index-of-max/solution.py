# Xom Data · Position of the priciest item in the table
# Problem: https://xomdata.com/practice/py-index-of-max
# Solved: 2026-08-21

def index_of_max(prices):
    if len (prices) ==0:
        return -1
    else:
        max_val = max(prices)

        max_idx = prices.index(max_val)
        return max_idx
