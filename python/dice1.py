#! /usr/bin/env python
import random
possible = [2, 3, 4, 5, 6, 7, 8, 10, 12, 14, 16, 20, 24, 30, 34, 50, 100]
size = int(raw_input('Please enter the size of the die you would like: '))
if size not in possible:
        print """
Please check the Wikipedia Dice article to get possible dice sizes.
I'm going to give you a standard 6 sided die to try out.
        """
        size = 6
rolltimes = int(raw_input('Please enter the number of times to roll: '))
dice = [x for x in range(1,size+1)]
rollval = []
dictionary = {}
for count in range(0,rolltimes):
        item = dice[random.randrange(len(dice))]
        dictionary[item] = dictionary.get(item,0) + 1

items = dictionary.keys()
items.sort()
for item in items:
        print "%-10s %d" % (item, dictionary[item])

