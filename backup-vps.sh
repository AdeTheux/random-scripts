#!/bin/bash

sudo rsync -avze "sudo -u $USER ssh -pPORT" -a arnaud@ssh.detheux.org:/var/www/ /Volumes/Other/VPS/var/www/
sudo rsync -avze "sudo -u $USER ssh -pPORT" -a arnaud@ssh.detheux.org:/etc/ /Volumes/Other/VPS/etc/
