# hour hand at 12
# min hand is moving
 
# input - mins
# output- angle between hour and mins
# eg. if input is 15, output will be 90, if input is 30, output is 180 etc.

def fn(mins):

    angle = mins * 6

    return angle

print(fn(15))