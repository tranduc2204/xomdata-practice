# Xom Data · Missing number
# Problem: https://xomdata.com/practice/py-missing-number
# Solved: 2026-08-29

def missing_number(numbers):
    n = len(numbers) + 1
    

    expected_sum = n * (n + 1) // 2
    

    actual_sum = sum(numbers)
    

    return expected_sum - actual_sum
