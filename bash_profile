#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Set Paths
#   ------------------------------------------------------------
    export PATH="/usr/local/bin:${PATH}"
#    export PATH="$PATH:/usr/local/bin/"
#    export PATH="/usr/local/git/bin:/sw/bin/:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
	export PATH="$PATH:/usr/local/bin/sshfs"
#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR='/usr/bin/vim'
	export GIT_EDITOR='/usr/bin/vim'


#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ls='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias python='python3'
alias pip='pip3'
# Color LS
colorflag="-G"
# DIRECTORY ALIASES
alias arnaud='cd /Users/Arnaud/Sites/Arnaud/arnaud/'
alias adtc='cd /Users/Arnaud/Sites/ADT\ Consulting/'
alias dev='cd /Users/Arnaud/Sites/Arnaud/dev/'
# COMMANDS ALIASES
alias rmf='rm -rf'
alias softupd='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'
alias chmod755='find . -type d -exec chmod 755 {} \;'
alias chmod644='find . -type f -exec chmod 644 {} \;'
# Git
# You must install Git first
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gp='git push'
alias grm='git rm $(git ls-files --deleted)'
alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs
# enable color support of ls and also add handy aliases
alias grep='grep -n --color=auto'
alias fgrep='fgrep -n --color=auto'
alias egrep='egrep -n --color=auto'
alias diff='diff -ruN'
## MacOS
# cleanup MacOS .DStore & ._* files
alias rmmac='find . -iname ".DS*" -exec rm -rf {} \; ; find . -iname "._*" -exec rm -rf {} \;'


#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page


# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡ "

#   ---------------------------------------
#   9.  COLORS
#   ---------------------------------------

# Set color variables
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


#   ---------------------------------------
#   9.  Change Prompt
#   ---------------------------------------

############################################

# Modified from emilis bash prompt script

# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1

#

# Modified for Mac OS X by

# @corndogcomputer

###########################################
# Fill with minuses

# (this is recalculated every time the prompt is shown in function prompt_command):

fill="___ "


reset_style='\[\033[00m\]'

status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color

prompt_style=$reset_style

command_style=$reset_style'\[\033[1;29\]' # bold black

# Prompt variable:


PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\[\033[38;5;208m\]\u \[\033[38;5;11m\]@ \[\033[38;5;14m\]\H \[\033[38;5;2m\]in \w\$'"$command_style \n
💻 > "


# Reset color for command output

# (this one is invoked every time before a command is executed):

trap 'echo -ne "\033[00m"' DEBUG


function prompt_command {


# create a $fill of all screen width minus the time string and a space:

let fillsize=${COLUMNS}-9

fill=""

while [ "$fillsize" -gt "0" ]

do

fill="-${fill}" # fill with underscores to work on

let fillsize=${fillsize}-1

done


# If this is an xterm set the title to user@host:dir

case "$TERM" in

xterm*|rxvt*)

bname=`basename "${PWD/$HOME/~}"`

echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"

;;

*)

;;

esac


}

PROMPT_COMMAND=prompt_command
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
