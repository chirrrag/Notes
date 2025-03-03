"""
"word"
'word'
"""

# create a string
name = "Chirag"
print(name)

# concatenate

surname = "Sapra"
print(name + surname)
print(name,surname)
print(name,"" + surname)


language = "python"
first_char = language[0]
third_char = language[2]
print(first_char,third_char)


# replace a string

sentence = "I love Java"
new_sentence = sentence.replace("Java", "Python")
print("old string is:",sentence)
print("replaced string is:",new_sentence)


# length of string
coding = "python"
print(len(coding))


# convert int to string
name = "Chirag"
age = 25
print(name , str(age))