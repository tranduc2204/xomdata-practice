# Xom Data · Second largest value
# Problem: https://xomdata.com/practice/py-second-largest
# Solved: 2026-08-25

def second_largest(numbers):
    arr =  (list(set(numbers)))
    arr =  (sorted(arr, reverse=True))
    if len (arr) >1:
        return (arr [1])
    else: 
        return None
