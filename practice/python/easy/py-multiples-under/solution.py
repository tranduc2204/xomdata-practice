# Xom Data · Reward milestones below a cap
# Problem: https://xomdata.com/practice/py-multiples-under
# Solved: 2026-08-23

def multiples_under(k, n):
    quan = n //k
    arr = []
   
    i = k
    while i < n:
        arr.append(i)
        i += k
    return (arr)
