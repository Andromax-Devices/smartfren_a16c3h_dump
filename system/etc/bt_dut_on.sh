#/bin/sh                                                                                                                            
echo "Start to excute cmd"
echo "Excute 'btconfig /dev/smd3 reset'"
btconfig /dev/smd3 reset
echo "Excute 'btconfig /dev/smd3 rawcmd 0x06, 0x03'"
btconfig /dev/smd3 rawcmd 0x06, 0x03
echo "Excute 'btconfig /dev/smd3 rawcmd 0x03, 0x05, 0x02, 0x00, 0x02'"
btconfig /dev/smd3 rawcmd 0x03, 0x05, 0x02, 0x00, 0x02
echo "Excute 'btconfig /dev/smd3 rawcmd 0x03, 0x1A, 0x03'"
btconfig /dev/smd3 rawcmd 0x03, 0x1A, 0x03
echo "Excute 'btconfig /dev/smd3 rawcmd 0x03, 0x20, 0x00'"
btconfig /dev/smd3 rawcmd 0x03, 0x20, 0x00
echo "Excute 'btconfig /dev/smd3 rawcmd 0x03, 0x22, 0x00'"
btconfig /dev/smd3 rawcmd 0x03, 0x22, 0x00
echo "Enter DUT"