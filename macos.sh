# environment
info() {
  echo "[+] $1"
}

err() {
  echo "[*] $1"
  exit 1
}

# checks

# homebrew
info "Installing homebrew"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# cli tools
info "Installing cli tools"
brew install\
    zsh\
    tmux\
    rsync\
    gnupg\
    pyenv\
    jenv\
    goenv\
    node\
    AdoptOpenJDK/openjdk/adoptopenjdk8\
    httpie\
    httrack\
    gron\
    docker-compose\
    dependency-check\
    coreutils\
    gnu-sed\
    docker\
    docker-compose

## oh-my-zsh
info "Installing oh-my-zsh"
rm -rdf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/plugins/zsh-history-substring-search
sed -i -e 's/# DISABLE_AUTO_UPDATE="true"/DISABLE_AUTO_UPDATE="true"/g' ~/.zshrc
sed -i -e 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-history-substring-search)/g' ~/.zshrc
echo '' >> ~/.zshrc
echo 'PROMPT="%(!.%{%F{yellow}%}.)$USER@%{$fg[white]%}%M %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'bindkey '^P' history-substring-search-up' >> ~/.zshrc
echo 'bindkey '^N' history-substring-search-down' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'alias l="ls -lh"' >> ~/.zshrc
echo 'alias la="ls -lha"' >> ~/.zshrc
echo 'alias lt="ls -lht"' >> ~/.zshrc
echo '' >> ~/.zshrc
chsh -s /bin/zsh

## gnu-sed
echo 'PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"' >> ~/.zshrc
echo '' >> ~/.zshrc

# pyenv
info "Installing pyenv"
export PYENV_ROOT=~/.pyenv
curl https://pyenv.run | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
echo '' >> ~/.zshrc

# python
info "Installing latest python"
zsh -c ". ~/.zshrc; git clone https://github.com/momo-lab/pyenv-install-latest.git "$(pyenv root)"/plugins/pyenv-install-latest; pyenv install-latest"

# setup tmux
echo "set-option -g prefix C-v" > ~/.tmux.conf

info "Installing GUI apps"
brew install --cask\
    smoothscroll\
    keka\
    clashx\
    google-chrome\
    pycharm-ce\
    intellij-idea-ce\
    goland\
    webstorm\
    wireshark\
    mpv\
    owasp-zap\
    onedrive\
    vmware-fusion

# finish
info "All done"
