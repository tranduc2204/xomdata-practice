# Xom Data · Count digits in the password
# Problem: https://xomdata.com/practice/py-count-digits
# Solved: 2026-08-25

def count_digits(text):
    # print (text)
    # print (text.isdigit())
    count_check = 0
   
    for x in text:
       
        if x.isdigit() == True:
            count_check +=1
    return  (count_check)
