# Xom Data · Digit frequency
# Problem: https://xomdata.com/practice/py-digit-frequency
# Solved: 2026-08-28

def digit_frequency(number):
    number = str(number)
    counts = {}
    # for  nu in number:
    #     print (nu)
    
    for nu in number:
        if nu in counts:
            counts[nu] += 1
        else:
            counts[nu] = 1
    return counts
