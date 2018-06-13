#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------
# define variables here
SERVER=www.test-site.com
FQDN=`nslookup $SERVER |grep Name: | awk '{ print \$2 }'`
IP=`nslookup $SERVER |grep Address: | awk '{ print \$2 }' | grep -v '#53'`
PORT=443
DELAY=1

# -------------------------------------------------------------------------------------------
echo ====================================================
echo FQDN: $FQDN
echo IP: $IP
echo Port: $PORT
echo ====================================================
echo
ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g')
echo ====================================================
echo Obtaining cipher list from $(openssl version)...
echo ====================================================
echo

# -------------------------------------------------------------------------------------------
for cipher in ${ciphers[@]}
do
echo -n Testing $cipher...
result=$(echo -n | openssl s_client -cipher "$cipher" -connect $FQDN:$PORT 2>&1)
if [[ "$result" =~ ":error:" ]] ; then
  error=$(echo -n $result | cut -d':' -f6)
  echo NO \($error\)
else
  if [[ "$result" =~ "Cipher is ${cipher}" || "$result" =~ "Cipher    :" ]] ; then
    echo YES
  else
    echo UNKNOWN RESPONSE
    echo $result
  fi
fi
sleep $DELAY
done
