# Xom Data · Mask phone number
# Problem: https://xomdata.com/practice/py-mask-phone
# Solved: 2026-08-20

def mask_phone(phone):
    # print (len(phone))
    return ('*'*(len(phone) -3)+phone[-3:])
