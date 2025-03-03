
# we also want to match decimal digit
# any digit matching :- \d
# + will match one or more character


import re
text = '''
The gross cost of fy2024 Q3 $4.5990 operating lease sfugaifb dasfkusgfb $21 adskfjbfakb  FY2023 Q1 was 8billion. sfubfb d wifubwfnsf sfjhbdjfcb sjf csdjc  FY2020 Q4'''

pattern = '\$[\d\.]+'
# or
pattern2 = '\$([0-9\.]+)'
match = re.findall(pattern, text)
match2 = re.findall(pattern2, text)
print(match)
print(match2)