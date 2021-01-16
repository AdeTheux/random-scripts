#!/bin/bash

#Convert to readable format
bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo ""
    echo "$b$d ${S[$s]} of space was cleaned up."
}
oldAvailable=$(df / | tail -1 | awk '{print $4}')

#Check if running as root and if not elevate
amiroot=$(sudo -n uptime 2>&1| grep -c "load")
if [ "$amiroot" -eq 0 ]
then
    echo "🔑 Cleanup Service requires root access. Please enter your password.\n"
    sudo -v
    echo ""
fi

# Keep-alive sudo until `cleanup.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "🧽 Cleaning Service has started..."

#Install Updates.
echo "🔄 Installing needed updates.\n"
softwareupdate -i -a > /dev/null

if type "brew" > /dev/null; then
    echo "🔄 Updating Homebrew recipes..."
    brew update
    echo "🔄 Upgrade and remove outdated formulae..."
    brew upgrade
    brew upgrade --cask
    brew cu --all -a
    echo "🧹 Cleanup Homebrew cache..."
    brew cleanup -s > /dev/null
    rm -rf $(brew --cache) > /dev/null
    echo "👨‍⚕️ Running Homebrew health checks..."
    brew doctor
    brew missing
    brew tap --repair > /dev/null
    echo "✅ Done updating and cleaning Homebrew."
fi

if type "gem" &> /dev/null; then
    echo "🔄 Updating gems..."
    gem update > /dev/null
    echo "🔄 Updating gem system..."
    gem update --system > /dev/null
    echo "🧹 Cleanup any old versions of gems..."
    gem cleanup > /dev/null
    echo "✅ Done updating and cleaning gem."
fi

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

if type "apm" &> /dev/null; then
    echo "⚛️ Upgrading Atom editor..."
    apm upgrade -c false
    echo "✅ Done upgrading Atom editor."
fi

echo "🧹 Delete all log and cache files..."
sudo rm -rf ~/Library/Application\ Support/Adobe/* > /dev/null
sudo rm -rf ~/Library/Application\ Support/CitrixOnline/* > /dev/null
sudo rm -rf ~/Library/Application\ Support/CrashReporter/* > /dev/null
sudo rm -rf /Library/Application\ Support/CrashReporter/* > /dev/null
sudo rm -rf ~/Library/Caches/* > /dev/null
sudo rm -rf ~/Library/Cookies/* > /dev/null
sudo rm -rf ~/Library/Icons/* > /dev/null
sudo rm -rf ~/Library/Logs/* > /dev/null
sudo rm -rf ~/Library/Saved\ Application\ State/* > /dev/null
sudo rm -rf ~/Library/Safari/Databases/* > /dev/null
sudo rm -rf ~/Library/Safari/LocalStorage/* > /dev/null
sudo rm -rf ~/Library/Safari/Touch\ Icons\ Cache/* > /dev/null
sudo rm -rf ~/Library/Safari/Favicon\ Cache/* > /dev/null
sudo rm -rf ~/Library/Safari/Template\ Icons/* > /dev/null
sudo rm -rf ~/Music/iTunes/iTunes\ Music/Downloads* > /dev/null
sudo rm -rf ~/Music/iTunes/Album\ Artwork/Cloud/* > /dev/null
sudo rm -rf ~/Music/iTunes/Album\ Artwork/Cloud\ Purchases/* > /dev/null
sudo rm -rf ~/Music/iTunes/Album\ Artwork/Custom/* > /dev/null
sudo rm -rf ~/Music/iTunes/Album\ Artwork/Download/* > /dev/null
sudo rm -rf ~/Music/iTunes/Album\ Artwork/Generated/* > /dev/null
sudo rm -rf ~/Music/iTunes/Album\ Artwork/Store/* > /dev/null
sudo rm -rf /Library/Caches/* > /dev/null
sudo rm -rf /Library/Logs/* > /dev/null
sudo rm -rf ~/.bash_sessions/* > /dev/null
sudo rm -rf ~/.zsh_sessions/* > /dev/null
sudo rm -rf /private/tmp/* > /dev/null
sudo rm -rf /private/var/folders/gs/ty91zcs96q3cmw39k6_mw9kw0000gp/0/* > /dev/null
sudo rm -rf /private/var/folders/gs/ty91zcs96q3cmw39k6_mw9kw0000gp/C/* > /dev/null
sudo rm -rf /private/var/folders/gs/ty91zcs96q3cmw39k6_mw9kw0000gp/T/* > /dev/null
sudo rm -rf /private/var/log/* > /dev/null
sudo rm -rf /private/var/tmp/* > /dev/null
sudo rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Mail\ Downloads/* > /dev/null
: > ~/.zsh_history
echo "✅ Done deleting all log and cache files."

echo "🧹 Delete all containers cache..."
for x in $(ls ~/Library/Containers/)
do
    echo "Deleting ~/Library/Containers/$x/Data/Library/Caches/"
    rm -rf ~/Library/Containers/$x/Data/Library/Caches/*
done
echo "✅ Done deleting all containers cache."

echo "🧹 Cleanup XCode derived data and archives..."
rm -rf ~/Library/Developer/Xcode/DerivedData/* > /dev/null
rm -rf ~/Library/Developer/Xcode/Archives/* > /dev/null
echo "✅ Done cleaning up XCode derived data and archives."

echo "🧠 Purge inactive memory..."
sudo purge
echo "✅ Done purging inactive memory."

echo "👏🏼 Cleaning Service has completed. Reboot now!"

newAvailable=$(df / | tail -1 | awk '{print $4}')
count=$((oldAvailable - newAvailable))
#count=$(( $count * 512))
bytesToHuman $count