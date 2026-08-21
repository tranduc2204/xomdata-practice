# Xom Data · Convert prices to US dollars
# Problem: https://xomdata.com/practice/py-vnd-to-usd
# Solved: 2026-08-21

def vnd_to_usd(amount, rate):
    return round (amount /rate,2)
