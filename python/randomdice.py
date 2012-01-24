from random import randint
def roll(dice = 1, sides = 6):
    try: return [randint(1, sides) for i in range(dice)]
    except: return []
