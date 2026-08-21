# Xom Data · Ticket price by age
# Problem: https://xomdata.com/practice/py-ticket-price
# Solved: 2026-08-21

def ticket_price(age):
    if age < 6:
        return 0
    elif age <=17 and age >=6:
        return 50000
    elif age <= 59 and age >= 18:
        return 100000
    elif age >= 60:
        return 50000
