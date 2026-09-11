# Xom Data · Extract domain from email
# Problem: https://xomdata.com/practice/py-email-domain
# Solved: 2026-09-11

def get_domain(email):
    index_ = email.index('@')

    strr = len(email)
    return  (email[index_+1:strr])
