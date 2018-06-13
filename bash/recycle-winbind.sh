#!/bin/bash
#: Title       : Recycle the AD cache for Winbind Services
#: Date        : 2015-11-30
#: Author      : John.Fensome@admiralgroup.co.uk
#: Version     : 0.1
#: Description : Script to Recycle the AD cache for Winbind Services
#: Options     : None

# -------------------------------------------------------------------------------------------
# declare colour variables for ease of reading
yellow='\033[33;40m'
grey='\033[0m'
green='\e[0;32m'
red='\e[0;31m'

echo -e "$yellow Please wait while we flush the cache and recycle the services..."
echo -e "$grey ================================================"
echo -e "$yellow Flushing the winbind cache..."
net cache flush;
sleep 5

echo -e "$yellow Reloading the winbind service...$grey"
service winbind reload;
sleep 5

echo -e "$yellow Reloading the samba service...$grey"
service smb reload
sleep 5
echo -e "$grey ================================================"

# output the current date and time
echo -e "$yellow Script last run:$grey `date`"
echo

# vim: ts=2:sw=2:ai:et
