
#!/bin/bash
echo " Available List Of Interfaces: "
ls /sys/class/net
intf=$(yad --center --width=250 --title "Alert" --buttons-layout=center --text="Enter The Interface to Spoof : " --entry )
until [ "$intf" == eth0 ] || [ "$intf" == wlan0 ]
do
intf=$(yad --center --width=250 --title "Alert" --buttons-layout=center --text="Invalid Value Entered, Please Enter a valid Interface to Spoof : " --entry )
done
echo " Stoping the Network Service: "
service NetworkManager stop
sleep 2
echo " Taking Down The Interface: "
ifconfig "$intf" down
sleep 2
echo " Changing the MAC address to a random one: "
macchanger -r "$intf"
sleep 2
echo " Bringing the Interface back up : "
sleep 2
ifconfig "$intf" up
echo " Restoring the Service: "
sleep 2
service NetworkManager start
echo " Done!!! "
exit
