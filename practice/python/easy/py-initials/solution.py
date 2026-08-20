# Xom Data · Generate initials
# Problem: https://xomdata.com/practice/py-initials
# Solved: 2026-08-20

def get_initials(full_name):
    arr  =[]
    for name in full_name.split():
       
        arr.append(name[0])
    return str("".join(str(a) for a in arr)).upper()
