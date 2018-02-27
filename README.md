# pi_webcam
Raspberry Pi WebCam ( Trim files, capture, timestamp, create gif, ftp to host )

This perl script uses a Raspberry Pi 3 and a Camera to create a web cam
The program is called from crontab every 5 minutes 
The working directory is /home/pi/webcam
The perl script does several tasks:-

Delete old jpg captures
Takes a photo
Timestamps that photo
Copies it to a time stamp jpg
convert is then called to create a gif animated file 
ftp is then utilised to ftp the gif to a remote site

Andrew Rich VK4TEC 
