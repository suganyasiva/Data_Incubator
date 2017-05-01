# -*- coding: utf-8 -*-
"""
Created on Fri Apr 28 11:59:24 2017

@author: Sugu
"""
import itertools
import numpy

N = 20
P = 160
a = list(xrange(1,N+1))

count = 0
c = 0
sum = 0
value_list = []
for i in itertools.permutations(a):
#    print i
    sum = 0
    for j, value in enumerate(i):
        if j == 0:
            sum = sum + value
        else:
            sum = sum + abs(value - i[j-1])
    value_list.append(sum)
    if sum >= P:
        c = c + 1
    count = count+1
    
print count
print numpy.mean(value_list)
print numpy.std(value_list)
print float(c)/float(count)