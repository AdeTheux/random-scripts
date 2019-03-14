#!/bin/bash

#Check if running as root and if not elevate
amiroot=$(sudo -n uptime 2>&1| grep -c "load")
if [ "$amiroot" -eq 0 ]
then
    echo "🔑 Cleanup Service requires root access. Please enter your password.\n"
    sudo -v
    echo ""
fi

# Keep-alive sudo until 'cleanup.sh' has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "🧽 Cleaning Service has started..."

#Install updates
echo "🔄 Installing needed updates..."
	apt-get update --fix-missing
	apt-get -y upgrade
	apt-get -y dist-upgrade
echo "✅ Done installing updates."

#Update gem, if installed
if type "gem" &> /dev/null; then
    echo "🔄 Updating gems..."
	gem update > /dev/null
    echo "🔄 Updating gem system..."
	gem update --system > /dev/null
    echo "🧹 Cleanup any old versions of gems..."
    gem cleanup > /dev/null
    echo "✅ Done updating and cleaning gem."
fi

#Update npm, if installed
if type "npm" &> /dev/null; then
	echo "🔄  Upgrading NPM itself..."
    npm install npm@latest -g
    echo "🔄 Updating npm binaries..."
    npm update -g
    apm upgrade -c false
    echo "🧹 Cleanup npm cache..."
    npm cache clean --force
    echo "👨‍⚕️ Running npm health check."
    npm doctor
    echo "✅ Done updating and cleaning npm."
fi

#Cleanup installs
echo "🔄 Cleaning installs..."
	apt-get clean
	apt-get -y autoclean
	apt-get -y autoremove
echo "✅ Done cleaning installs."

#Update grub
echo "🔄 Updating grub..."
	update-grub
echo "✅ Done updating grub."

#Virus scan
echo "🦠 Running virus scan..."
	clamscan -voi
echo "✅ Done running virus scan."

echo "👏🏼 Cleaning Service has completed. Reboot now!"