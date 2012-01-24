#!/bin/bash
# Arch Linux update script
# by Lutherus 
#Wed Nov 30 20:10:27 CET 2011
#

# Colors
blue="33[1;34m"
green="33[1;32m"
red="33[1;31m"
bold="33[1;37m"
reset="33[0m"
 
# Check for root
if [ $(whoami) != "root" ]; then
    echo -e $red"error:$reset you cannot perform this operation unless you are root."
    exit 1
fi
 
# Update
yaourt -Syua --noconfirm
echo -e "$blue:: Updating mlocate database $reset"

echo -e "$green:: System update complete $reset"
exit 0
