#!/user/bin/python2
import random

print "---Welcome to this D&D dice roller.---"
print "\____________________________________/"
print "-----Remeber, your DM hates you-------"
  
def dice_roller():
   
   print "------Please choose a dice.------"
   print 
   print "1) d2 "
   print "2) d3 "  
   print "3) d4 "  
   print "4) d6 "  
   print "5) d8 "  
   print "6) d10 "  
   print "7) d% "  
   print "8) d12 "  
   print "9) d20 "  
 
   sum = raw_input("What dice? ")

   if sum == '1':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 3)
         j = j + 1
   elif sum == '2':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 4)
         j = j + 1
   elif sum == '3':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 5)
         j = j + 1
   elif sum == '4':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 7)
         j = j + 1
   elif sum == '5':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 9)
         j = j + 1
   elif sum == '6':
      dice = float(raw_input("Number of dices: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 11)
         j = j + 1
   elif sum == '7':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled", random.randrange(1, 101),"percent"
         j = j + 1
   elif sum == '8':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 13)
         j = j + 1
   elif sum == '9':
      dice = float(raw_input("Number of dice: "))
      j = 1
      while j <= dice:
         print "You rolled a", random.randrange(1, 21)
         j = j + 1
  

input = 'C'
while 1:
   if   input == 'Q': break
   elif input == 'C': dice_roller()
   input = raw_input("Press c to continue or q to quit: ").upper()
