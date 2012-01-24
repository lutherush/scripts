#! /bin/bash
ifconfig wlan0
iwconfig wlan0 essid ERROR403:Network_Forbidden key 20r$\5F2
dhclient wlan0
