# Xom Data · Reverse words in a string
# Problem: https://xomdata.com/practice/py-reverse-words
# Solved: 2026-09-05

def reverse_words(sentence):
    # sentence= sentence.strip()
    # if len(sentence) == 0:
    #     return ""
    # else: 
    #     result = sentence.split(' ')
    
    #     result_v1 =  (' '.join(result[::-1]))
    #     return result_v1
    words = sentence.split()
    
    # Nối mảng đã đảo ngược lại bằng 1 khoảng trắng
    return ' '.join(words[::-1])
