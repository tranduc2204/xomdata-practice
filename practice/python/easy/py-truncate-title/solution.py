# Xom Data · Shorten an over-long title on an article card
# Problem: https://xomdata.com/practice/py-truncate-title
# Solved: 2026-08-21

def shorten(text, limit):
    if len(text) > limit:
        return text[:limit] + "..."
    return text
