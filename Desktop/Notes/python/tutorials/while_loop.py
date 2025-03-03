


total = 0
j = 1
while j < 5:
    total += j
    j += 1
print(total)


l1 = [5,4,4,-2,-3,1,2,3]
sum=0
i=0
while i < len(l1) and l1[i] > 0:
    sum += l1[i]
    i += 1
print(sum)


ans = 0
for element in l1:
    if element <= 0:
        break
    ans += element
print(ans)


l2 = [5,4,4,3,1,-2,-3,-5]
total5 = 0
i = 0
while True:
    total5 += l2[i]
    i += 1
    if l2[i] <= 0:
        break
print(total5)