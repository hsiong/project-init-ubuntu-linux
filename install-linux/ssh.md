https://www.jianshu.com/p/b294e9da09ad

## ssh修改登录端口禁止密码登录并免密登录

[![img](https://cdn2.jianshu.io/assets/default_avatar/3-9a2bcc21a5d89e21dafc73b39dc5f582.jpg)](https://www.jianshu.com/u/2d6754d78777)

[何建博桑](https://www.jianshu.com/u/2d6754d78777)IP属地: 四川

0.7122016.12.11 20:38:25字数 718阅读 41,712

------

author: hjb2722404
head: [https://avatars1.githubusercontent.com/u/10215241?v=3&s=460](https://link.jianshu.com/?t=https://avatars1.githubusercontent.com/u/10215241?v=3&s=460)
date: 2016-12-10
title: ssh修改登录端口禁止密码登录并免密登录
tags: : SSH linx远程
category: tech-linux
status: publish
summary: 本文记录在CentOS7中修改ssh登录端口，免密登录ssh以及ssh禁止口令登录的方法，最后达到保证服务器安全的目的。

------

### 1.修改ssh登录端口

#### 1.1 登录远程linux主机：

```shell
#linux:

$ ssh user@ip -p port
#windows git-bash:

# ssh user@ip port
```

#### 1.2 修改ssh登录端口

```shell
#以下操作在远程linux主机中操作：

$ vi /etc/ssh/sshd_config
```

找到`sshd_config`文件中如下选项并修改：

```shell
#Port 22

#修改为：

Port 60022 #这里修改为你想要设置的端口,以60022为例
```

#### 1.3 修改防火墙配置

```shell
$ vi /etc/sysconfig/iptabels
```

添加以下规则

```shell
-A INPUT -m state --state NEW -m tcp -p tcp --dport 60022 -j ACCEPT
```

修改完成后，刷新iptables并重启ssh服务

```shell
$ systemctl restart iptables.service
$ systemctl restart sshd.service
```

此时如果再使用22端口进行ssh连接，就会报错，用60022端口连接才可以建立。

### 2.免密登录

SSH免密登录利用了rsa密钥对匹配的原理，可以允许用户从本地不用密码就可以访问到远程主机，让我们来看看怎么做。

#### 2.1 本地生成密钥对

```shell
# 在本机命令行控制台输入：

$ ssh-keygen
```

会有提示，连续按三次回车。

此时会在系统用户的.ssh目录下生成一对密钥文件：私钥文件id_rsa和公钥文件id_rsa_pub。

#### 2.2 将本地公钥内容追加到远程主机的授权文件（authorized_keys）中

本地查看id_rsa_pub文件内容：

```shell
$ cat ~/.ssh/id_rsa_pub
```



复制得到的公钥字符串，在远程服务器上编辑authorized_keys文件：

```shell
$ vi .ssh/authorized_keys
```

将刚刚得到的本地公钥字符串添加到该文件的末尾（如果是新建的文件就直接添加）

编辑保存完成后，修改该文件的权限：

```shell
$chmod 600 .ssh/authorized_keys
```

#### 2.3 修改ssh配置

编辑远程服务器上的`sshd_config`文件：

```shell
$vi /etc/ssh/sshd_config
```

找到如下选项并修改(通常情况下，前两项默认为no，地三项如果与此处不符，以此处为准)：

```shell
#启用密钥验证
RSAAuthentication yes
PubkeyAuthentication yes
#指定公钥数据库文件
AuthorsizedKeysFile.ssh/authorized_keys
```

编辑保存完成后，重启ssh服务使得新配置生效：

```shell
$ systemctl restart sshd.service
```

此时，就可以通过ssh命令免除密码直接登录远程主机了，在本地命令行控制台输入：

```shell
$ ssh user@ip -p 60022
```

就可以了（第一次需要输入密码，以后就不用了）

#### 3. 禁止SSH口令登录

为了安全性更高，我们既然已经使用了密钥免密登录，那么就可以直接禁止再使用口令来连接SSH远程主机了。

#### 3.1 更改ssh配置

编辑远程服务器上的`sshd_config`文件：

```shell
$vi /etc/ssh/sshd_config
```

找到如下选项并修改(通常情况下，前两项默认为no，地三项如果与此处不符，以此处为准)：

```shell
#PasswordAuthentication yes 改为
PasswordAuthentication no
```

编辑保存完成后，重启ssh服务使得新配置生效，然后就无法使用口令来登录ssh了

```shell
$ systemctl restart sshd.service
```

最后编辑于 ：2017.12.05 01:19:49

©著作权归作者所有,转载或内容合作请联系作者
【社区内容提示】社区部分内容疑似由AI辅助生成，浏览时请结合常识与多方信息审慎甄别。
平台声明：文章内容（如有图片或视频亦包括在内）由作者上传并发布，文章内容仅代表作者本人观点，简书系信息发布平台，仅提供信息存储服务。



# ssh 基础
## 使用SSH从服务器下载或上传文件
从远程服务器下载文件到本地
```
scp <用户名>@<ssh服务器地址>:<文件> <本地文件路径>
scp root@127.20.36.88:~/test.txt ~/Desktop
```

## 从远程服务器下载文件夹到本地
```
scp -r <用户名>@<ssh服务器地址>:<文件夹名> <本地路径>
scp -r root@127.20.36.88:~/test ~/Desktop
```

## 从本地上传文件到服务器上
```
scp <本地文件名> <用户名>@<ssh服务器地址>:<上传保存路径> 
```
## 从本地上传文件夹到服务器上
```
scp  -r <本地文件夹名> <用户名>@<ssh服务器地址>:<上传保存路径> 
```

## ssh 密码登录
ubuntu@xxxx: Permission denied (publickey).  如何使用密码登录

## ssh 免密登录
https://www.jianshu.com/p/b294e9da09ad

## ssh: root@domain 异常, root@ip 成功
> 错误码: 
>
> kex_exchange_identification: Connection closed by remote host
>
> Connection closed by 127.0.0.1 port 7890 

+  https://www.zhihu.com/question/20023544, 根据文档, 注意到 Connection closed by 127.0.0.1 port 7890 
  7890 是我的 vpn 的端口, 关闭 vpn 后重试  `ssh -v root@domain`

+ 提示: domain: nodename nor servname provided, or not known

  考虑域名解析是否被停用, 发现 www 域名的确被停用了, 启用域名解析

  ![image](https://user-images.githubusercontent.com/37357447/217993033-b3dd34c4-2c91-4a8b-b1f7-f19ceb982ca0.png)

+ 等待 5 分钟, 依然提示: nodename nor servname provided, or not known

  `vim ~/.ssh/known_hosts`, 删除 domain 对应的记录

## install uniVPN in Ubuntu
+ download uniVPN 
+ `chmod -x xxx.run`
+ `sudo ./xxx.run`

## ssh remote connection refused
+ 检查 ssh 状态
systemctl status ssh
ssh localhost

+ 检查 ssh 端口
netstat -ntlp

+ 检查 网路状态
telnet ip port
ping ip

+ 检查防火墙
iptables -L 
ufw status
firewall-cmd --list-ports

+ 重置 ssh
删除 .ssh 文件
重新生成新的 ssh gen



## scp 指定端口上传文件
scp -r -P port ./* videoai@$ip:~/docker/java

## ssh 指定端口
ssh -p port

## Remove key from known_hosts
vim ~/.ssh/known_hosts

## 解决ssh登录后闲置时间过长而断开连接
https://blog.csdn.net/abld99/article/details/69388858

一、客户端保持连接（最常用）

1 修改 SSH 客户端配置（推荐）:

编辑客户端配置文件：

```
vim ~/.ssh/config
```

加入：

```
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 5
```
