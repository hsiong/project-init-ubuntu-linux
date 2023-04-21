# project-init-ubuntu
轻量云主机如今日渐深入人心, 但是云主机的初始化和镜像迁移无疑是个非常痛苦的过程; 

本项目致力于快速配置基于Ubuntu 20的云主机初始化和镜像迁移; 

未来总结经验, 一键生成开发环境(可能会通过 docker-file 或 shell 或 ansible)的形式

# trans file 
```shell
scp -r /localDir remoteUser@remoteAddr:/remoteDir
```



# ssh 
> su root
> sudo rootCode
## ssh root login
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/v2v_guide/preparation_before_the_p2v_migration-enable_root_login_over_ssh
## ssh key login & no Password Authentication
https://www.jianshu.com/p/b294e9da09ad
```shell
# local
ssh-keygen
cat ~/.ssh/id_rsa.pub

# remote
vim .ssh/authorized_keys

# copy id_rsa.pub to .ssh/authorized_keys
# restart ssh
systemctl restart sshd.service
```

no Password Authentication

```shell
sudo vim /etc/ssh/sshd_config

# set sshd_config -> PasswordAuthentication no
# restart ssh
systemctl restart sshd.service
```

## ssh ServerAliveInterval
https://blog.csdn.net/abld99/article/details/69388858
```shell
echo 'ServerAliveInterval 60' >> /root/.ssh/config

systemctl restart sshd.service
```



# terminal

## apt install yum
```shell
sudo apt-get update & apt-get install yum
```
## zsh 

Before your start, copy oh-my-zsh to your remote dir

```shell
scp -r localDir/Projects/github/project-init-ubuntu-linux/oh-my-zsh remoteUser@remoteAddr:/remoteDir/zsh
```



### install OH-MY-ZSH
> https://www.spacevast.com/archives/centos7-linux%E5%AE%89%E8%A3%85zsh%E5%92%8Coh-my-zsh%E5%86%85%E5%90%AB%E5%9B%BD%E5%86%85%E5%AE%89%E8%A3%85%E6%96%B9%E6%B3%95

> https://www.kwchang0831.dev/dev-env/ubuntu/oh-my-zsh

[install.sh](oh-my-zsh/install.sh)

```shell
# remote 
cd /remoteDir/zsh
sh install.sh
```



> fatal: unable to access 'https://github.com/ohmyzsh/ohmyzsh.git/': GnuTLS recv error (-110): The TLS connection was non-properly terminated.

```shell
# remote-china
cd /remoteDir/zsh
sh install-china.sh
```



> Do you want to change your default shell to zsh? [Y/n] y

### plugins

+ zsh-syntax-highlighting ：提供了语法高亮显示。
+ zsh-autosuggestions ：它会根据历史记录和完成情况建议您键入的命令，而且快速/不干扰自动提示。
+ zsh-completions ：命令自动补全。

[install_zsh_plugins.sh](oh-my-zsh/plugins/install_zsh_plugins.sh)

```shell
# remote copy
cd /remoteDir/zsh/plugins 
cp -r ./* ~/.oh-my-zsh/custom/plugins

# remote install 
apt-get install unzip

# unzip plugins
cd ~/.oh-my-zsh/custom/plugins 
unzip \*.zip
```



### customize color
[color.sh](oh-my-zsh/color/color.sh)

```shell
cd /remoteDir/zsh/color 
cp color.sh	~/.oh-my-zsh/custom/plugins
```



### config zsh-config
[zshrc](oh-my-zsh/zshrc)  

```shell
# copy zshrc to ~/.zshrc
vim ~/.zshrc

# source it
source ~/.zshrc
```



# apt - vim
## show line number
http://c.biancheng.net/view/809.html#:~:text=%E5%9C%A8%E5%91%BD%E4%BB%A4%E6%A8%A1%E5%BC%8F%E4%B8%8B%E8%BE%93%E5%85%A5,%E5%A6%82%E5%9B%BE1%20%E6%89%80%E7%A4%BA%E3%80%82&text=%E5%A6%82%E6%9E%9C%E6%83%B3%E8%A6%81%E5%8F%96%E6%B6%88%E8%A1%8C,%E6%96%87%E4%BB%B6%E6%89%80%E5%9C%A8%E5%9C%B0%EF%BC%89%E4%B8%AD%E8%AF%BB%E5%8F%96.

```
echo 'set nu' >> ~/.vimrc
```

# Linux config DNS
https://blog.csdn.net/u010416101/article/details/79719713

```shell
cat /etc/resolv.conf
```



# docker 

## install docker 

```shell
su root
# 更新 apt
apt-get update
# 安装必要的 ca 工具
apt-get install ca-certificates curl gnupg lsb-release
# 添加GPG密钥
-fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# 添加docker软件源
add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# 下载并安装docker
apt install docker-ce
# 配置docker-mirror为阿里源
touch /etc/docker/daemon.json
echo '{ "registry-mirrors": ["https://ra9q5uam.mirror.aliyuncs.com"] }' > /etc/docker/daemon.json
# 重启docker服务
service docker restart
```



## docker - not use root

```shell
USER=ubuntu

# $USER is your username
sudo usermod -aG docker $USER

# make usermod take effect
newgrp docker
```

## docker - redis

docker run -d --name myredis -p 6379:6379 redis --requirepass "mypassword"

## docker - postgresGis
docker run -d --name postgres -p 5432:5432 -e POSTGRES_USER=usr -e POSTGRES_PASSWORD=pwd kartoza/postgis

## docker - nginx
docker run --name nginx -p 80:80 \
-v /root/config/docker/:/etc/nginx/conf.d/ \
-v /root/download:/usr/share/nginx/download \
-d nginx
### nginx config

## docker - jekins
### jekins - maven - optimize
https://www.cnblogs.com/yatho/p/7233194.html
