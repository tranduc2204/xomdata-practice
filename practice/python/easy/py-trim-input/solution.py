# Xom Data · Clean up stray spaces in a list of names
# Problem: https://xomdata.com/practice/py-trim-input
# Solved: 2026-08-21

def clean_names(raw_list):
    # return raw_list.strip()
    arr = []
    for r in raw_list:
        arr.append(r.strip())
    
    return (arr)
