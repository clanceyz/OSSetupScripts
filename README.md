# About
Scripts for setting up security features and convenient utilities on Operating Systems.

# Features
* Security
    * ssh
        * change port to 60294
        * PermitRootLogin without-password
        * PasswordAuthentication no
* Tools
    * vim, curl, wget, tmux, net-tools, git, zsh, rsync, git, gcc, make, openssl, jdk8.
    * oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh.
    * zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions.
    * Change tmux shortcut from C-b to C-v to resolve conflict with cursor back shortcut of bash/zsh.
    * docker & docker-compose: https://www.docker.com/

# Warning
* __First of all, setup a ssh key__, otherwise you will no longer be able to log in to ssh because of security settings. The easiest way is to use __ssh-copy-id__ command
* The ssh port will be changed from __22__ to __60294__ for security concern.

# Install
* macOS
```shell
curl -fsSL "https://github.com/clanceyz/OSEnvScripts/raw/master/macos.sh" | sh
```
* Ubuntu
```shell
curl -fsSL "https://github.com/clanceyz/OSEnvScripts/raw/master/ubuntu.sh" | sudo sh
```
