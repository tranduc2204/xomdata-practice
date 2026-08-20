# Xom Data · Add up the day's slip numbers
# Problem: https://xomdata.com/practice/py-sum-to-n
# Solved: 2026-08-20

def sum_to(n):
    if n == 0:
        return 0
    else:
        return sum(x for x in range(n+1))
    print(n)
