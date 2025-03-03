char_count = {}
def most_frequent_char(input_string):
#  char_count = {}
 for char in input_string:
     print("before" , char_count)
     char_count[char] = char_count.get(char,0) + 1
     print("after" , char_count)
 return max(char_count, key=char_count.get)  

print("heyy")
print(most_frequent_char("chiirrrag"))

print(char_count)
print(max(char_count))
key = char_count.get('r')
print(key)