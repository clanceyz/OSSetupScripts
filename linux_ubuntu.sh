# environment
_SSH_PORT=60294
_USER=${USER}
_HOME="$(echo ~)"
if [ ! -z ${SUDO_USER} ]; then
  _USER=${SUDO_USER}
  _HOME="/home/${_USER}"
fi

info() {
  echo "[+] $1"
}

err() {
  echo "[*] $1"
  exit 1
}

# checks
## ssh key
if [ ! -e "${HOME}/.ssh/authorized_keys" ]; then
  err "Please set up a ssh key first (~/.ssh/authorized_keys). Otherwise, you will no longer be able to log in to ssh because of security settings."
fi

# install dependencies
info "Installing dependencies"
apt update
apt-get install -y vim curl wget tmux net-tools git zsh rsync gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev zlib1g-dev openjdk-8-jdk

# reinforce ssh
info "Setting up ssh reinforcement"
sed -i "s/#Port 22/Port ${_SSH_PORT}/g" /etc/ssh/sshd_config
sed -i -E 's/#?PermitRootLogin.*/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i -E 's/#?PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config
service sshd restart

# Utilities
## oh-my-zsh
export ZSH="${_HOME}/.oh-my-zsh"
info "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-${_HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
mv ~/.zshrc "${_HOME}"
sed -i 's/# DISABLE_AUTO_UPDATE="true"/DISABLE_AUTO_UPDATE="true"/g' "${_HOME}/.zshrc"
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' "${_HOME}/.zshrc"
echo '' >> "${_HOME}/.zshrc"
echo 'PROMPT="%(!.%{%F{yellow}%}.)$USER@%{$fg[white]%}%M %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"' >> "${_HOME}/.zshrc"
echo '' >> "${_HOME}/.zshrc"
echo 'alias l="ls -lh"' >> "${_HOME}/.zshrc"
echo 'alias la="ls -lha"' >> "${_HOME}/.zshrc"
echo 'alias lt="ls -lht"' >> "${_HOME}/.zshrc"
echo '' >> "${_HOME}/.zshrc"
chown -R ${_USER}:${_USER} "${_HOME}/.oh-my-zsh"
chsh -s /usr/bin/zsh

## pyenv
info "Installing pyenv"
export PYENV_ROOT="${_HOME}/.pyenv"
curl https://pyenv.run | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> "${_HOME}/.zshrc"
echo 'eval "$(pyenv init --path)"' >> "${_HOME}/.zshrc"
echo 'eval "$(pyenv virtualenv-init -)"' >> "${_HOME}/.zshrc"
echo '' >> "${_HOME}/.zshrc"
chown -R ${_USER}:${_USER} "${_HOME}/.pyenv"

info "Installing latest python"
su ${_USER} -c "zsh -c \". ~/.zshrc; git clone https://github.com/momo-lab/xxenv-latest.git /home/ubuntu/.pyenv/plugins/xxenv-latest; pyenv latest install; pyenv latest global\""

## tmux
info "Setting up tmux"
echo "set-option -g prefix C-v" > "${_HOME}/.tmux.conf"
chown -R ${_USER}:${_USER} "${HOME}/.tmux.conf"

## finish
# change owner of directories
chown -R ${_USER}:${_USER} ${HOME}/.ssh

info "Done"

info "You can now login ssh on new port ${_SSH_PORT}"

