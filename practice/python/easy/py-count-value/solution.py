# Xom Data · Count occurrences of a code
# Problem: https://xomdata.com/practice/py-count-value
# Solved: 2026-08-25

def count_value(items, target):

    count = 0
    for i in items:
        if i == target:
            count +=1
    return count
