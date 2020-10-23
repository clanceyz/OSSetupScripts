# About
Scripts for setting up convenient utilities and security features on Operating Systems.

# features
* security
    * ssh
        * port 60294
        * PermitRootLogin without-password
        * PasswordAuthentication no

# warning
* first of all, setup a ssh key. The easiest way is to use __ssh-copy-id__ command
* the ssh port will change to 60294 for security concern.

# install
* ubuntu
```shell script
curl -fsSL "https://github.com/clanceyz/OSEnvScripts/raw/master/linux_ubuntu.sh" | sh
```
