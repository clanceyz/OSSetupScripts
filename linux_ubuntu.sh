# install dependencies
apt update
apt-get install -y vim curl wget tmux net-tools git zsh rsync git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev zlib1g-dev openjdk-8-jdk

# reinforce ssh
sed -i 's/#Port 22/Port 60294/g' /etc/ssh/sshd_config
sed -i -E 's/#?PermitRootLogin.*/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i -E 's/#?PasswordAuthentication.*/PasswordAuthentication no/g' /etc/ssh/sshd_config
service sshd restart

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/# DISABLE_AUTO_UPDATE="true"/DISABLE_AUTO_UPDATE="true"/g' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/g' ~/.zshrc
echo '' >> ~/.zshrc
echo 'PROMPT="%(!.%{%F{yellow}%}.)$USER@%{$fg[white]%}%M %{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"' >> ~/.zshrc
echo '' >> ~/.zshrc
echo 'alias l="ls -lh"' >> ~/.zshrc
echo 'alias la="ls -lha"' >> ~/.zshrc
echo 'alias lt="ls -lht"' >> ~/.zshrc
echo '' >> ~/.zshrc

# tmux
echo "set-option -g prefix C-v" > ~/.tmux.conf
