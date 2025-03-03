import math
def contains_only_digits(input_string):
    return input_string.isdigit() 

print(contains_only_digits(12341234))
print(contains_only_digits("12341234"))
print(contains_only_digits("1234123axs4"))
print(contains_only_digits("axxsxAA"))
print(contains_only_digits(True))