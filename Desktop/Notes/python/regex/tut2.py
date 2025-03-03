# any character except abc :- [^abc]
# more of a :- a+, means more of b:- b+
# zero or more of a :- a*
# zero or more of b :- b*
# "()" it will match only the sequence inside those parenthesis

import re
pattern = 'Note \d - ([^n\]*)'
str = """
Note 1 - Overview 
sdaifbslifbsdlifsbhkjklkbjkbjkbbkkbkbdsafsdikfbgjsdikgbsdikfgnsadgfousdghsohg
Note-2 City in the house
aioufhao
"""
re.findall(pattern,str)