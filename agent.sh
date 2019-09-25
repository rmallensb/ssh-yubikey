#!/bin/bash

var1=$( ssh-add -L )

cert_missing=true

# Check to see if the SSH Agent has access to your ssh-key
IFS=' ' read -ra LINE <<< "$var1"
for i in "${LINE[@]}"; do
  if [[ $i == *ssh-keychain.dylib* ]]; then
    cert_missing=false
  fi
done

# If the agent does not have access, reissue the command
# to reinitialize the state of your agent
if [[ $cert_missing == true ]]; then
  echo "Agent can't find ssh key, reissuing command"
  echo 
  ssh-add -e /usr/lib/ssh-keychain.dylib; ssh-add -s /usr/lib/ssh-keychain.dylib
fi
