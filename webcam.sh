#!/bin/sh
#
# Clear Screen
#
clear
#
# Get rid of old files ( mtime is in secs ) back
#
echo "********************"
echo "* Cleanup files    *"
echo "********************"
cd /home/pi/webcam
echo " "
echo "Getting rid of files > 2 hours in /home/pi/webcam/"
echo " "
sudo find /home/pi/webcam/*.jpg -mmin +120 -exec rm -f {} \;
#
# Take a photo
#
sleep 5
clear
echo "********************"
echo "* Take a photo     *"
echo "********************"
sudo rm -rf /home/pi/webcam/webcam*.*
sudo rm -rf /home/pi/webcam/pre*.jpg
cd /home/pi/webcam
OPTIONS='-w 800 -h 600 -q 80 -x'
DATE=$(date +"%d/%m/%Y")
HOUR=$(date +"%R")
sudo raspistill -v -vf -hf -o /home/pi/webcam/precam.jpg $OPTIONS
echo " "
echo "Picture taken"
echo " "
ls -lrt /home/pi/webcam/pre*.jpg
echo " "
sleep 5
clear
echo "********************"
echo "* Timestamp Photo  *"
echo "********************"
echo " "
echo "Timestamping /home/pi/webcam/webcam.jpg"
echo " "
ls -lrt /home/pi/webcam/precam.*
echo " "
convert /home/pi/webcam/precam.jpg  \
-pointsize 14 -fill white -annotate +670+590  \
$DATE \
-pointsize 14 -fill white -annotate +750+590  \
$HOUR \
-pointsize 14 -draw "gravity southwest \
fill white text 15,6 '<user> WebCam ( 2 hours every 5 mins )' " \
/home/pi/webcam/webcam.jpg
echo " "
echo "Here is a list of time stamped files already made in /home/pi/webcam/"
echo " "
sudo cp /home/pi/webcam/webcam.jpg /home/pi/webcam/"cam.$(date +%F_%R).jpg"
ls -lrt /home/pi/webcam/cam*.jpg
#sudo rm /home/pi/webcam/webcam*.*
#
# mash into gif
#
sleep 5
clear
echo "********************"
echo "* Create GIF Movie *"
echo "********************"
cd /home/pi/webcam
echo " "
echo "Input files :-"
echo " "
ls -lrt /home/pi/webcam/cam*.jpg
echo " "
echo "Processing"
echo " "
sudo convert -delay 50 -loop 0 /home/pi/webcam/cam*.jpg /home/pi/webcam/webcam.gif
echo " "
echo "Output file :-"
echo " "
ls -lrt /home/pi/webcam/*.gif
echo " "
#
# ftp
#
sleep 5
clear
echo "********************"
echo "* ftp webcam.gif   *"
echo "********************"
sleep 2
echo " "
echo "Uploading /home/pi/webcam/webcam.gif"
echo " "
HOST='<ftp host>'
USER='<user>'
PASSWD='<password>'
FILE='webcam.gif'
ftp -v -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
debug
lcd /home/pi/webcam
binary
put $FILE
chmod 777 webcam.gif
ls
quit
END_SCRIPT
echo " "
echo "Done...."
echo " "
echo "http://<url>/webcam/webcam.gif"
echo " "
sleep 2
exit 0
