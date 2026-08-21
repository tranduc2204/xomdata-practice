# Xom Data · Convert minutes to hours and minutes
# Problem: https://xomdata.com/practice/py-time-format
# Solved: 2026-08-21

def format_duration(minutes):
    # print (minutes // 60)
    # print (minutes % 60)
    hour = minutes // 60
    minutes = minutes % 60
   

    return (f"{hour}:{minutes:02}")
