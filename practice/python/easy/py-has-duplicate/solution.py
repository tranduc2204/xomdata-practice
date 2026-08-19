# Xom Data · Spot a code entered twice
# Problem: https://xomdata.com/practice/py-has-duplicate
# Solved: 2026-08-19

def has_duplicate(items):
   
    if len(items) == 0:
        return False
    for i in items:
        # Nếu bất kỳ phần tử nào xuất hiện từ 2 lần trở lên trong list
        if items.count(i) > 1:
            return True # Trả về True ngay lập tức
            
    return False # Duyệt hết mà không thấy trùng thì trả về False
