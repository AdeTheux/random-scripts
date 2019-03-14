#!/bin/sh
#/Library/Filesystems/osxfusefs.fs/Support/load_osxfusefs
#sysctl -w osxfuse.tunables.allow_other=1
sshfs USER@ssh.detheux.org:/ /Users/Arnaud/VPS -o identityfile=/Users/Arnaud/.ssh/id_rsa,port=PORT,auto_cache,reconnect,defer_permissions,noappledouble,follow_symlinks,volname=VPS,local
