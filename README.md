# ssh-yubikey
Use your yubikey with a forwarding agent for your ssh key

## Steps

* `Run yubikey_ssh_piv.sh`, it will prompt you for a passphrase (limit is 8 characters, remember this)

* In order to setup the forwarding agent, run:
  
  ```
  ssh-add -e /usr/lib/ssh-keychain.dylib; ssh-add -s /usr/lib/ssh-keychain.dylib
  ```
  
  You will be prompted for your passphrase

* Copy `agent.sh` into your home directory and add the following to the bottom of your `.bash_profile`

  ```
  eval ~/agent.sh
  ```
 
## Notes
* The third step is optional. After shutting down your computer, the state of your forwarding agent is lost and it will not know where your ssh key is. The third step will re-establish your forwarding agent in this event.

* The `yubikey_ssh_piv.sh` script may become depricated due to migration from the **yubico-piv-tool** to **yubico-manager**.
