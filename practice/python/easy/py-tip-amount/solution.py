# Xom Data · Restaurant tip suggestion
# Problem: https://xomdata.com/practice/py-tip-amount
# Solved: 2026-08-21

def tip_amount(bill, percent):
    if bill >= 0 and percent >= 0 and percent <=100:
        return round (bill /100*percent,2)
