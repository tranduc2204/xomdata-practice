# Xom Data · Look a price up by product code
# Problem: https://xomdata.com/practice/py-price-lookup
# Solved: 2026-08-24

def price_of(prices, code):
    # print (prices)
    # print (code)
    count = 0
    result =0
    for it in prices.items():
        if it[0] == code:
            result = it[1]
            count+=1
    if count > 0:
        return result 
    else: 
        return 0
