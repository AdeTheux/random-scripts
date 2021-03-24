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
    apt-get -y -o Dpkg::Options::="--force-confdef" upgrade
    apt-get -y -o Dpkg::Options::="--force-confdef" dist-upgrade
echo "✅ Done installing updates."

#Cleanup installs
echo "🔄 Cleaning installs..."
    apt-get clean
    apt-get -y autoclean
    apt-get -y autoremove --purge
echo "✅ Done cleaning installs."

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

#Update grub
echo "🔄 Updating grub..."
    update-grub
echo "✅ Done updating grub."

#cleanup /tmp directories
echo "🧹 Cleanup temp files..."
    rm -rf /tmp/*
    rm -rf /var/tmp/*
echo "✅ Done cleaning temp files."

#Virus scan
echo "🦠 Running virus scan..."
    clamscan -r --bell -i /home/arnaud/
    clamscan -r --bell -i /root/
echo "✅ Done running virus scan."

echo "🧹 Deleting node modules"
    rm -rf /home/arnaud/Documents/cleanup/node_modules/

echo "Cleanup script ran on $(date)" >> /var/log/cleanup/cleanup.log

echo "ℹ️ Sending confirmation to Slack"
    slack-webhook-monitoring -l "crit" -t "🏡 Nexus cleanup" -m ":broom: Cleanup script ran succesfully. Rebooting..."

echo "👏🏼 Cleaning Service has completed. Rebooting now..."

    reboot