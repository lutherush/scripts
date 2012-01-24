#!/bin/bash

# set variable for trash directory
TRASHDIR="/home/lutherus/.local/share/Trash"

# display size of TRASHDIR
du -hs $TRASHDIR

# pause for 3 seconds before continuing
sleep 3

# delete everything in TRASHDIR
rm --recursive --verbose $TRASHDIR/
