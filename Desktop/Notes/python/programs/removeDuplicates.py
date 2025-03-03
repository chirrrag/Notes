
def remove_duplicates(input_string):
 return "".join(sorted(set(input_string), key=input_string.index)) 

print(remove_duplicates("sapppafadvwedvwera"))

