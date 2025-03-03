salaries = {"Chirag": 200000, "Megha": 1500000}

name, salary = max(salaries.items(), key=lambda x: x[1])

print(f"{name} has salary {salary}")