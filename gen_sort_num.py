# generate 100 random numbers
import random
num = 1000
nums = ['%s' %random.randint(1,100) for i in range(num)]
print(num, ' '.join(nums))
