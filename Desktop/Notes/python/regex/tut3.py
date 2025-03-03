# contains a single character of a,b or c :- [abc]
# contains single character of A,4,j :- [A4j]
# any character in range a-z or A-Z:- [a-zA-Z]
# any character in range 1-8:- [1-8]
# to ignore cases :- re.findall(pattern, text, flags=re.IGNORECASE)
# () :- these bracket will print only that content which is present inside it
import re

text = '''
The gross cost of fy2024 Q3 operating lease sfugaifb dasfkusgfb adskfjbfakb  FY2023 Q1 was 8billion. sfubfb d wifubwfnsf sfjhbdjfcb sjf csdjc  FY2020 Q4'''

pattern = 'FY\d{4} Q[1234]'
match = re.findall(pattern,text)

print(match)

# we can also do this via

ans = 'FY\d{4} Q[1-4]'
ans = re.findall(ans,text)
print(ans)

finalAns = 'FY\d{4} Q[1-4]'
finalAns = re.findall(finalAns, text, flags=re.IGNORECASE)
print(finalAns)

finalAns = 'FY(\d{4} Q[1-4])'
finalAns = re.findall(finalAns, text, flags=re.IGNORECASE)
print(finalAns)