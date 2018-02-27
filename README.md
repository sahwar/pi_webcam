# pi_webcam

Raspberry Pi WebCam ( Trim files, capture, timestamp, create gif, ftp to host )

This bash script uses a Raspberry Pi 3 and a Camera to create a web cam ( single shots )

The program is called from crontab every 5 minutes 
*/5 * * * * root /home/pi/webcam/webcam.sh

The working directory is /home/pi/webcam
The bash script does several tasks:-

+ Delete old jpg captures /home/pi/webcam/cam*.jpg
+ Takes a photo /home/pi/webcam/precam.jpg
+ Timestamps that photo /home/pi/webcam/precam.jpg webcam.jpg
+ Copies it to a time stamp jpg /home/pi/webcam/cam*.jpg
+ convert is then called to create a gif animated file /home/pi/webcam/cam* /home/pi/webcam/webcam.gif 
+ ftp is then utilised to ftp the gif to a remote site /home/pi/webcam/webcam.gif

Andrew Rich VK4TEC 
