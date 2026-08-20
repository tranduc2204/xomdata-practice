# Xom Data · Library late return fee
# Problem: https://xomdata.com/practice/py-late-fee
# Solved: 2026-08-20

def late_fee(days_late, fee_per_day):
    if fee_per_day < 0:
        return 0
    elif days_late <= 0:
        return 0
    else:
        return days_late * fee_per_day
