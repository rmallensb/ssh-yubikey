#!/bin/bash

var1=$( ssh-add -L )

cert_missing=true

IFS=' ' read -ra LINE <<< "$var1"
for i in "${LINE[@]}"; do
  if [[ $i == *ssh-keychain.dylib* ]]; then
    cert_missing=false
  fi
done

if [[ $cert_missing == true ]]; then
  echo "Agent can't find ssh key, reissuing command"
  echo 
  ssh-add -e /usr/lib/ssh-keychain.dylib; ssh-add -s /usr/lib/ssh-keychain.dylib
fi
