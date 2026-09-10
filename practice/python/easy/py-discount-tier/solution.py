# Xom Data · Discount tier by order value
# Problem: https://xomdata.com/practice/py-discount-tier
# Solved: 2026-09-10

def discount_percent(total):
    if total < 500000:
        return  0
    elif total >= 500000 and total < 2000000:
        return 5
    elif total >= 2000000:
        return 10
