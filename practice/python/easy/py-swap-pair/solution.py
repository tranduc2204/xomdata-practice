# Xom Data · Swap two storage slots
# Problem: https://xomdata.com/practice/py-swap-pair
# Solved: 2026-08-20

def swap_slots(a, b):
    c = a
    a = b
    b = c

    return (a,b)
