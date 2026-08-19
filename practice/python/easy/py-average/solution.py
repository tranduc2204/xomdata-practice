# Xom Data · Average score by subject
# Problem: https://xomdata.com/practice/py-average
# Solved: 2026-08-19

def average_score(scores):
    total = 0
    xlen = len(scores)
    if xlen == 0:
        return 0
    else:
        result = 0
        for s in scores:
            total += s
        return round (total / xlen,2)
