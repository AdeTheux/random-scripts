#!/bin/bash
sudo rsync -avzeP "sudo -u $USER ssh -pPORT" -a root@vps.detheux.org:/var/www/ /Volumes/Backup\ Other/VPS/var/www/
