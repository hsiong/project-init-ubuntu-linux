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

**最关键一步：引导加载器安装位置**

直接物理卸载硬盘

在安装界面底部有一行：

```
Device for boot loader installation:
```

一定要选择你的移动硬盘，比如：

```
/dev/sdb
```

> #### **安装错 boot 怎么办**
>
> lsblk -f
>
> sudo mkdir /mnt/win-efi
>
> sudo umount /mnt/win-efi
>
> sudo mount /dev/nvme0n1p1 /mnt/win-efi
>
> ls /mnt/win-efi/EFI
>
> sudo rm -rf /mnt/win-efi/EFI/ubuntu
>
> 
>
> sudo efibootmgr
>
> sudo efibootmgr -b 0005 -B

## Install

### vim

```
sudo apt update

sudo apt install vim -y
```

### oh-my-zsh

**1. 安装 Zsh**

```
sudo apt update
sudo apt install zsh git -y
```

------

🔍 **2. 检查是否安装成功**

```
zsh --version
```

如果显示版本号（例如 `zsh 5.9`），说明安装成功。

------

💡 **3. 设置默认 Shell 为 Zsh**

```
chsh -s $(which zsh)
```

然后退出重新登录（或重启终端），Zsh 就会成为默认的 Shell。

> ⚠️ 如果没有立即生效，可以重新登录账户，或者在终端手动输入：
>
> ```
> zsh
> ```

------

🎨 **4. （推荐）安装 Oh My Zsh**

Oh My Zsh 是一个让 Zsh 更漂亮、更强大的配置框架。 => 使用国内镜像

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

安装后你会看到一个新的、彩色的命令提示符。

> setttings -> Keyboard  -> shortcut -> bindings
>
> + ctrl + alt + t -> Lauch terminal -> unassigned
>
> + Add custom shortcut

------

🧠 **5. 可选：更换主题 / 插件**

- 修改配置文件：

  ```
  nano ~/.zshrc
  ```

- 修改主题：

  ```
  ZSH_THEME="agnoster"
  ```

- 常见插件（自动补全 / 高亮）：

  ```
  sudo apt install zsh-autosuggestions zsh-syntax-highlighting
  ```

  然后在 `~/.zshrc` 中添加：

  ```
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ```

> `plugins=(git zsh-autosuggestions zsh-syntax-highlighting) `改为 `plugins=(zsh-autosuggestions zsh-syntax-highlighting)`
>
> 否则会因为 git 原因卡死

### VPN

+ v2rayN
  + subscript
  + update
+ sublime ~/.zshrc

```
# run clashx
export https_proxy=http://127.0.0.1:7890 
# export http_proxy=http://127.0.0.1:7890 
# export all_proxy=socks5://127.0.0.1:7890
export http_proxy=
export all_proxy=
```

### DeskFlow

+ 使用 flatpak 安装

```
sudo apt install flatpak

http_proxy=http://127.0.0.1:10808 \
https_proxy=http://127.0.0.1:10808 \
flatpak install --user ./deskflow-1.20.1-linux-x86_64.flatpak
```

+ 启动

```
flatpak run org.deskflow.deskflow
```

可以`Coinfigure Server`来调整左右屏幕

+ 自启动   使用 Cinnamon 自启动（图形界面）【推荐】
  + 打开菜单 → **系统设置** → **启动应用程序 (Startup Applications)**
  + 点击 “添加” → “自定义命令”
  + 填写：

> 名称：Deskflow
>
> 命令：`flatpak run org.deskflow.deskflow`

### 我想让 Guake 完全替代默认终端

因为原生 terminal 不支持撤销和重做

ctrl + c & ctrl + v 也不支持

### Chrome



### Sublime



### Typora



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

