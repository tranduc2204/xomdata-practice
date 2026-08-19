# Xom Data · Branch leading on revenue
# Problem: https://xomdata.com/practice/py-best-branch
# Solved: 2026-08-19

def best_branch(branches):
   
   
    if not branches:
        return None
    
    # max() evaluates items based on their value (the second element in item()),
    # and if there's a tie, it keeps the first one encountered due to left-to-right evaluation.
    return max(branches, key=branches.get)
