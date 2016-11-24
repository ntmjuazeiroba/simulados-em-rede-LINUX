#!/bin/bash
if [ "$(id -u)" != "0" ]; then
echo
echo "Voce deve executar este script como root!"
echo

else


/opt/lampp/bin/mysqldump -u root moodle > ~/moodle-old.sql
apt-get remove simulados-em-rede
apt-get remove moodle2.9
mv /opt/lampp /opt/lampp-old
rm /usr/bin/mysql*
cp -r tmp/* /tmp/
cp -r usr/* /usr/
cd /tmp/xampp/
cat X* > xampp-linux-5.6.11-1-installer.run
chmod +x xampp-linux-5.6.11-1-installer.run

xterm -e ./xampp-linux-5.6.11-1-installer.run

cd /tmp/
cp /tmp/moodledata.zip /opt/lampp/
cp /tmp/moodle.zip /opt/lampp/htdocs/
cp /tmp/moodle.sql ~/
cp /tmp/criarBD.sh ~/

chmod 777 ~/moodle.sql
chmod 777 ~/criarBD.sh


cd /opt/lampp/
unzip moodledata.zip -d .

cd /opt/lampp/htdocs/
unzip moodle.zip -d .

chmod -R 777 /opt/lampp/moodledata
chmod -R 777 /opt/lampp/htdocs/moodle

/opt/lampp/lampp start

cd /tmp/
cp /tmp/rc.local /etc/
chmod +x /etc/rc.local
/opt/lampp/lampp start
/opt/lampp/lampp start

/opt/lampp/bin/mysql -u root -e "DROP DATABASE moodle"
/opt/lampp/bin/mysql -u root -e "CREATE DATABASE moodle"
/opt/lampp/bin/mysql -u root moodle < /tmp/moodle.sql

zenity --info --text="Projeto instalado! Agora, o sistema será reiniciado, para que teste a instalação do moodle, em caso de problemas, execute o script criarBD.sh que está na pasta do usuário"

sudo reboot

fi