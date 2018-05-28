# egawow
Egawow project


# Initialization
Enter `raspi-config`
```
sudo raspi-config
```
and setting up following belows 

1. Network > Hostname
	> i.e.) egawow000

2. Network > wifi
	> Japan > cncupsul.u-aiu.ac.jp > uoacnlab

3. Localization > keyboard
	> Apple(ANSI) > Japaese > No > No

4. Interface > camera
	> Enable
	
	
	
# Configuration
Run below code
```bash
$(curl -sSfL https://raw.githubusercontent.com/sak39/egawow/master/etc/init.sh) | sudo bash - 
```


# Done!