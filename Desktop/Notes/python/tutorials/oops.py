class Robot:
    # constructor
    def __init__(self, name, color, weight):
        self.name = name
        self.color = color
        self.weight = weight

    def introduce_self(self):
        print("My name is: " + self.name) # this in java
# self refers to object
# we have to add self in every method in python
# method is function of class which are called by "."separator

# creating object out of this class
# r1 = Robot()
# r1.name = "prateek"
# r1.color = "White"
# r1.weight = 30

# r1.introduce_self()

r1 = Robot("prateek","white",40)
# r1.introduce_self()
r2 = Robot("Jerry","blue",40)


# multiple classes and object can interact with each otehr
class Person:
    # constructor
    def __init__(self, n, p, i):
        self.name = n
        self.personality = p
        self.is_sitting = i
    def sit_down(self):
        self.is_sitting = True
    def stand_up(self):
        self.is_sitting = False

p1 = Person("Alice","aggressive",False)
p2= Person("Becky","talkative",True)

# p1 owns robot R2
p1.robot_owned =r2
p2.robot_owned =r1

# print info of robot r2 with help of Alice
p1.robot_owned.introduce_self()


