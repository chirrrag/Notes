import re

str = "Tesla phone number is 9996667777 and his other number is (919)-424-8898"

pattern = '\(\d{3}\)-\d{3}-\d{4}|\d{10}'

matches = re.findall(pattern, str)
print(matches)
