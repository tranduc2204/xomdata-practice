# Xom Data · Count products with an even code
# Problem: https://xomdata.com/practice/py-count-even
# Solved: 2026-08-25

def count_even(numbers):
    #  x=  (nu for nu in numbers if nu % 2 ==0)
    count = 0
    for nu in numbers:
        if nu % 2 == 0:
            count +=1
    return count
