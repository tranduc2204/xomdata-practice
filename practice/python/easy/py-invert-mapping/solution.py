# Xom Data · Flip a code-to-name lookup table
# Problem: https://xomdata.com/practice/py-invert-mapping
# Solved: 2026-08-20

def invert(mapping):
    arr = {}
    for key, value in mapping.items():
        arr[value] = key  # Assigns the original value as the new key, and key as the value
    return arr
