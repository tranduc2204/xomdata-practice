# Xom Data · Group products by category
# Problem: https://xomdata.com/practice/py-group-category
# Solved: 2026-08-26

from collections import defaultdict

def group_by_category(items):\

    grouped_data = defaultdict(list)

    for key, value in items:

        grouped_data[value].append(key)
        # print (key, value)
    return(dict(grouped_data))
