# [^\$] :- any character but dollar sign


import re
text = '''
The gross cost of fy2024 Q3  operating lease sfugaifb $4.5990 dasfkusgfb $21 adskfjbfakb  FY2023 Q1 was 8billion. sfubfb d $4.12414 wifubwfnsf sfjhbdjfcb sjf csdjc  FY2020 Q4'''

match = 'FY(\d{4} Q[1-4])[^\$]+\$([0-9\.]+)'
ans = re.findall(match,text, flags=re.IGNORECASE)
print(ans)

# find all matches all occurennces 
# search matched first occurence
ans = re.search(match,text)
print(ans.groups())