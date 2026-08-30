# Xom Data · Check strong password
# Problem: https://xomdata.com/practice/py-password-strength
# Solved: 2026-08-30

def is_strong(password):
    upper_check = 0 
    lower_check = 0 
    atleast = len(password)
    digit = 0
    for pa in password:
        if pa.isupper() == True:
            upper_check +=1
        elif pa.islower() == True:
            lower_check +=1
        elif pa.isdigit() == True:
            digit +=1
    print (upper_check, lower_check, atleast, digit)
    if upper_check > 0 and lower_check > 0 and atleast >=8 and digit > 0:
        return True
    else:
        return False
