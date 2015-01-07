#!/bin/bash

function pause()
{
   read -p "$*"
}

#Updating OS
pause "Press Enter to update O/S"
apt-get update
apt-get dist-upgrade

#Setting up Metasploit database
pause "Press Enter to setup Metasploit database (note this does NOT
enable Metasploit Logging"
service postgresql start
service metasploit start

#Setting up Discover Scripts
pause "Press Enter to setup Discover Scripts"
cd /opt
git clone https://github.com/leebaird/discover.git
cd discover
./setup.sh

#Install Smbexec
pause "Press Enter to install Smbexec"
cd /opt
git clone https://github.com/brav0hax/smbexec.git
cd smbexec
pause "Press Enter to open up Smbexec script. Select 1 when prompted
and indicate you wish to install to /opt"
./install.sh
pause "Press Enter to open up Smbexec script again. Select 4 when prompted."
./install.sh

#Download Veil
pause "Press Enter to install Veil"
#Veil eventually wants to chown /root/veil-output, but it doesn't exist.
#I create it here as a directory so the error won't show up but it hope it won't
#cause problems in the future
mkdir /root/veil-output
cd /opt
git clone https://github.com/veil-evasion/Veil.git
cd ./Veil/setup
./setup.sh

#Download WCE
pause "Press Enter to install WCE"
cd ~/Desktop
wget http://www.ampliasecurity.com/research/wce_v1_41beta_universal.zip
unzip -d ./wce wce_v1_41beta_universal.zip

#Downloading Mimikatz
pause "Press Enter to install Mimikatz"
cd ~/Desktop
wget http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip
unzip -d ./mimikatz mimikatz_trunk.zip

#Getting big password lists
pause "Press Enter to open a browser with a password list to download.
This is different from the URL in the book (which is dead!!)"
firefox https://www.dropbox.com/s/ucreldsa3qt1rms/crackstation-human-only.txt.gz
pause "Press Enter once the previous password list has been downloaded
into ~/Downloads"
cd ~/Desktop
mkdir ./password_list && cd ./password_list
gzip -d ~/Downloads/crackstation-human-only.txt.gz
#wget errors on this sites expired certificate for me, so ignore the warning
wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
bzip2 -d rockyou.txt.bz2

#Install Burp Proxy manually
pause "Press Enter to open a web browser to download Burp Suite"
firefox http://portswigger.net/burp/downloadfree.html
pause "Press Enter once Burp Suite has been downloaded"

#Setting up Peepingtom
pause "Press Enter to install Peepingtom"
cd /opt
git clone https://bitbucket.org/LaNMaSteR53/peepingtom.git
cd ./peepingtom
wget https://gist.github.com/nopslider/5984316/raw/423b02c53d225fe8dfb4e2df9a20bc800cc78e2c/gnmap.pl
wget https://phantomjs.googlecode.com/files/phantomjs-1.9.2-linux-i686.tar.bz2
tar xvjf phantomjs-1.9.2-linux-i686.tar.bz2
cp ./phantomjs-1.9.2-linux-i686/bin/phantomjs .

#Installing Nmap script
pause "Press Enter to install Nmap script"
cd /usr/share/nmap/scripts
wget https://raw.github.com/hdm/scan-tools/master/nse/banner-plus.nse

#Installing PowerSploit
pause "Press Enter to install PowerSploit"
cd /opt
git clone https://github.com/mattifestation/PowerSploit.git
cd PowerSploit
wget https://raw.github.com/obscuresec/random/master/StartListener.py
wget https://raw.github.com/darkoperator/powershell_scripts/master/ps_encoder.py

#Installing Responder
pause "Press Enter to install Responder"
cd /opt
git clone https://github.com/SpiderLabs/Responder.git

#Installing SET
pause "Press Enter to install SET"
cd /opt
git clone https://github.com/trustedsec/social-engineer-tool-kit/set/
cd set
./setup.py install

#Installing bypassuac
pause "Press Enter to install bypassuac"
cd /opt
wget http://www.secmaniac.com/files/bypassuac.zip
unzip bypassuac.zip
cp bypassuac/bypassuac.rb /opt/metasploit/apps/pro/msf3/scripts/meterpreter
mv bypassuac/uac /opt/metasploit/apps/pro/msf3/data/exploits

#Installing BeEF
pause "Press Enter to install BeEF"
apt-get install beef-xss

#Installing Fuzzing Lists
pause "Press Enter to install Fuzzing Lists"
cd /opt
git clone https://github.com/danielmiessler/SecLists.git

#Installing Firefox Extensions
pause "Press Enter to open pages to each Firefox web browser
extension. Install each one."
firefox https://addons.mozilla.org/en-US/firefox/addon/web-developer
firefox https://addons.mozilla.org/en-US/firefox/addon/tamper-data
firefox https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard
firefox https://addons.mozilla.org/en-US/firefox/addon/user-agent-switcher

#We're done!
pause "Thats it! Press Enter to exit this script"
