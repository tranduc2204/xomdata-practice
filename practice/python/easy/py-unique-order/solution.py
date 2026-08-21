# Xom Data · Remove duplicate names from the invite list
# Problem: https://xomdata.com/practice/py-unique-order
# Solved: 2026-08-21

def unique(items):
    # print (list(set(items)))
    return (list(dict.fromkeys(items)))

    # deduplicated = list(dict.fromkeys(fruits))
