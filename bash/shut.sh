#!/bin/bash
#iCETonic's mpdshutdown.sh - Shutdown PC after MPD stops playing

#Info-Warning
echo "System is going to halt after MPD has finished playing! ^C to abort"

#Check loop
while [ "$(mpc playlist | head -c 1)" != ">" ] && [ "$(mpc | wc -l)" != "1" ]
    do
        sleep 10
    done

#Finished -> Shutdown
sudo shutdown -h now
