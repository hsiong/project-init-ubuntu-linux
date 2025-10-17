# 准备

## Refus 烧录

+ linux mint
+ GPT
+ Fat32 / exFat
+ DD Image mode
  + ISO 适用于 Windows
+ 提前分区 >200GB
+ 安全模式
  + msi: F11
+ Start  Cinnamon 64-bit

## Mint 磁盘分配

### ✅ 标准推荐方案

| 分区             | 挂载点      | 文件系统 | 大小     | 说明                       |
| ---------------- | ----------- | -------- | -------- | -------------------------- |
| EFI 分区         | `/boot/efi` | FAT32    | 512 MB   | 系统引导分区（UEFI 必需）  |
| 交换空间（Swap） | 无挂载点    | swap     | 4–8 GB   | 系统休眠/虚拟内存          |
| 家目录分区       | `/home`     | ext4     | 80 GB    | 存放用户文件               |
| 根分区           | `/`         | ext4     | 其余全部 | 系统文件及软件(apt, deb等) |

## Install

### oh-my-zsh

Refer: https://blog.csdn.net/ksws0292756/article/details/79953155

+ `sudo apt-get install gnome-tweaks gnome-shell-extensions ` 

> `plugins=(git zsh-autosuggestions zsh-syntax-highlighting) `改为 `plugins=(zsh-autosuggestions zsh-syntax-highlighting)`
>
> 否则会因为 git 原因卡死



### VPN

+ sublime ~/.zshrc

```
# run clashx
export https_proxy=http://127.0.0.1:7890 
# export http_proxy=http://127.0.0.1:7890 
# export all_proxy=socks5://127.0.0.1:7890
export http_proxy=
export all_proxy=
```



### Sublime



### pokemonsay



### Java



### Python



### Node



### Git

+ ~./zshrc

```
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```



### Pycharm



### Idea



### Graphic & Internet Drivers



### Wechat



### BaiduDisk





# 其他问题

## 【ubuntu更新驱动后联不上网】

https://blog.csdn.net/weixin_47869094/article/details/140512275

常见: 使用 autoinstall 导致内核更新

+ 查看内核版本：uname -a

+ 查看缺少的包: 输入 dpkg --get-selections | grep linux

+ 在可以联网的电脑上

  ```
  sudo apt-get install linux-headers-xxx
  sudo apt-get install linux-headers-xxx-generic
  sudo apt-get install linux-modules-extra-xxx-generic
  ```



## Nemo 
+ sftp://user@host/dir

