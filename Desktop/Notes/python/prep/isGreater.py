salaries = [{"Name": "Chirag", "Salary" : 20000}, {"Name": "Megha", "Salary" : 23000}]

max_salary = 0
max_name = ""

for person in salaries:
    if person["Salary"] > max_salary:
        max_salary = person["Salary"]
        max_name = person["Name"]

print(f"{max_name} has highest salary with saalary: {max_salary}")