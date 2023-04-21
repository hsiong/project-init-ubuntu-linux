# github 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
 
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions


# or cp & unzip
## local ~/project-init-ubuntu/oh-my-zsh/plugins
scp -r ~/project-init-ubuntu/oh-my-zsh/plugins/* user@ip:/root/.oh-my-zsh/custom/plugins

# or local copy
cd /remoteDir/zsh/plugins 
cp -r ./* ~/.oh-my-zsh/custom/plugins

# remote
apt-get install unzip

cd /root/.oh-my-zsh/custom/plugins 
unzip \*.zip