# Xom Data · Average score by class
# Problem: https://xomdata.com/practice/py-average-per-group
# Solved: 2026-08-25

from collections import defaultdict


def average_per_group(pairs):
    totals = defaultdict(lambda: [0, 0])

    for key, value in pairs:
        totals[key][0] += value  # Add to the sum
        totals[key][1] += 1      # Increase the count

    # Calculate the final averages
    averages = {key: current_sum / count for key, (current_sum, count) in totals.items()}

    return(averages)
