# Xom Data · Check palindrome
# Problem: https://xomdata.com/practice/py-palindrome
# Solved: 2026-08-24

def is_palindrome(text):
    # print (text[0:])
    # print (len(text))
    # print (text[::-1])

    one = text[0:].lower()
    two = text[::-1].lower()
    if one ==two:
        return True
    else: 
        return False
