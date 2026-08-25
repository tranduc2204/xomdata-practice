# Xom Data · Check prime number
# Problem: https://xomdata.com/practice/py-is-prime
# Solved: 2026-08-25

def is_prime(n):
    if n <= 1:
        return False
    
    for i in range(2,  int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True
